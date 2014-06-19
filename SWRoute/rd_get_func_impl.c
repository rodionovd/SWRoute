//
//  rd_get_func_impl.c
//  SWRoute
//  
//  Copyright © 2014 Dmitry Rodionov <i.am.rodionovd@gmail.com>
//  This work is free. You can redistribute it and/or modify it under the
//  terms of the Do What The Fuck You Want To Public License, Version 2,
//  as published by Sam Hocevar. See the COPYING file for more details.

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
