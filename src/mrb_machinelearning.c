/*
** mrb_machinelearning.c - MachineLearning module
** Copyright (c) Hiroyuki Matsuzaki 2015
**
** See Copyright Notice in LICENSE
*/

#include "mruby.h"
#include "mruby/data.h"
#include "mrb_machinelearning.h"
#include "mrb_naivebayes.h"

#define DONE mrb_gc_arena_restore(mrb, 0);

void mrb_mruby_machinelearning_gem_init(mrb_state *mrb)
{
    struct RClass *machinelearning;
    machinelearning = mrb_define_module(mrb, "MachineLearning");
    mrb_define_const(mrb, machinelearning, "VERSION", mrb_str_new_cstr(mrb, "0.0.1"));

    /* NaiveBayes class initialize */
    mrb_mruby_naivebayes_init(mrb, machinelearning);

    DONE;
}

void mrb_mruby_machinelearning_gem_final(mrb_state *mrb)
{
}
