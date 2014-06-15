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

------

If you found any bug(s) or something, please open an issue or a pull request — I'd appreciate your help! `(^,,^)`

------

*Dmitry Rodionov, 2014*  
*i.am.rodionovd@gmail.com*
