//
//  rd_get_func_impl.c
//  SWRoute
//
//  Created by Dmitry Rodionov on 6/15/14.
//  Copyright (c) 2014 rodionovd. All rights reserved.
//

#include <stdint.h>

#define kObjectFieldOffset 0x8

struct swift_func_object {
    uint64_t *original_type_ptr;
    uint64_t *unknown0;
    uint64_t function_address;
    uint64_t *self;
};

uint64_t _rd_get_func_impl(void *func)
{
    struct swift_func_object *obj = (struct swift_func_object *)*(uint64_t *)(func + kObjectFieldOffset);

    return obj->function_address;
}