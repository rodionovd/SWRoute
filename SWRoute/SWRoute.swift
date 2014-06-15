//
//  SWRoute.swift
//  SWRoute
//
//  Created by Dmitry Rodionov on 6/15/14.
//  Copyright (c) 2014 rodionovd. All rights reserved.
//

import Darwin

@asmname("_rd_get_func_impl")
    func rd_get_func_impl<Q>(Q) -> UInt64;
@asmname("rd_route")
    func rd_route(UInt64, UInt64, CMutablePointer<UInt64>) -> CInt;

class SwiftRoute {
    class func replace<MethodT>(function targetMethod : MethodT, with replacement : MethodT) -> Int
    {
        // @todo: what can we do with a duplicate of the original function?
        return Int(rd_route(rd_get_func_impl(targetMethod), rd_get_func_impl(replacement), nil));
    }
}