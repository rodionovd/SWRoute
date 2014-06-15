`SWRoute` is a tiny Swift wrapper over [`rd_route()`](https://github.com/rodionovd/rd_route). It allows you to route (hook) quite any function/method with another function/method or even a closure.  
  
If you're curious how it works, check our my blog post [„Function hooking in Swift“](http://rodionovd.github.io/funandprofit/2014/06/13/Function-hooking-in-Swift.html).  

#### Exported interface  

```haskell
class SwiftRoute {
    class func replace<MethodT>(function targetMethod : MethodT, with replacement : MethodT) -> Int
}
```

##### Arguments

 Argument   | Type (in/out) | Description
 :--------: | :-----------: | :----------
 `function` | in  | _**(required)**_ a function/method to override
 `with` | in| _**(required)**_ any other function/method or closure to overrride a `function` with


##### Return value  

`KERN_SUCCESS` (== 0) upon success, `> 0` otherwise.

##### Example usage
(see `SWRouteTests/SWRouteTests.swift` for more)  

```haskell
class DemoClass {
    func demoMethod(arg: Int) -> Int {
        return (42 + arg);
    }
}

var err = SwiftRoute.replace(function: DemoClass().demoMethod, with: {
    (arg : Int) -> Int in
        return (90 + arg)
})
XCTAssert(err == Int(KERN_SUCCESS), "", file: __FILE__, line: __LINE__)
XCTAssert(DemoClass().demoMethod(arg) == (90 + arg), "", file: __FILE__, line: __LINE__)

```

## SWRoute and iOS  

Unfortunately `rd_route` (the back-end of `SWRoute`) doesn't work well on iOS (until jailbroken), because it does some tricks with memory pages that aren't allowed there. But you can choose any other library for function hooking instead!  I recommend [`libevil`](https://github.com/landonf/libevil_patch) by Landon Fuller:  

```haskell
@asmname("evil_init")
    func evil_init();
@asmname("evil_override_ptr")
    func evil_override_ptr(UInt64, UInt64, CMutablePointer<UInt64>) -> CInt;

evil_init()
evil_override_ptr(rd_get_func_impl(DemoClass().demoMethod,
                  rd_get_func_impl(someFunction),
                  nil)
```

------

If you found any bug(s) or something, please open an issue or a pull request — I'd appreciate your help! `(^,,^)`

------

*Dmitry Rodionov, 2014*  
*i.am.rodionovd@gmail.com*
