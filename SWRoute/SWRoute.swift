//
//  SWRoute.swift
//  SWRoute
//  
//  Copyright © 2014 Dmitry Rodionov <i.am.rodionovd@gmail.com>
//  This work is free. You can redistribute it and/or modify it under the
//  terms of the Do What The Fuck You Want To Public License, Version 2,
//  as published by Sam Hocevar. See the COPYING file for more details.

import Darwin

@asmname("_rd_get_func_impl")
    func rd_get_func_impl<Q>(Q) -> uintptr_t;
@asmname("rd_route")
    func rd_route(uintptr_t, uintptr_t, UnsafePointer<uintptr_t>) -> CInt;

class SwiftRoute {
    class func replace<MethodT>(function targetMethod : MethodT,
                                     with replacement : MethodT,
                                          originalImp : UnsafePointer<uintptr_t> = nil) -> Int
    {
        let err = rd_route(rd_get_func_impl(targetMethod), rd_get_func_impl(replacement), originalImp);
        return Int(err);
    }
}
