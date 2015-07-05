/*
** mrb_naivebayes.c - NaiveBayes class
** Copyright (c) Hiroyuki Matsuzaki 2015
**
** See Copyright Notice in LICENSE
*/

#include "mruby.h"
#include "mruby/data.h"
#include "mruby/array.h"
#include "mruby/hash.h"
#include "mrb_naivebayes.h"

typedef struct {
  mrb_value vocabularies;
  mrb_value category_count;   /* category : count */
  mrb_value word_count;       /* category : { words : count } */
} mrb_naivebayes_data;

static void mrb_naivebayes_free(mrb_state *mrb, void *data)
{
  mrb_free(mrb, data);
}

static const struct mrb_data_type mrb_naivebayes_data_type = {
  "mrb_naivebayes_data", mrb_naivebayes_free,
};

static mrb_value
mrb_naivebayes_initialize(mrb_state *mrb, mrb_value self)
{
  mrb_naivebayes_data *data;

  data = (mrb_naivebayes_data *)DATA_PTR(self);
  if (data) {
    mrb_free(mrb, data);
  }
  DATA_TYPE(self) = &mrb_naivebayes_data_type;
  DATA_PTR(self) = NULL;

  data = (mrb_naivebayes_data*)mrb_malloc(mrb, sizeof(mrb_naivebayes_data));
  data->vocabularies = mrb_ary_new(mrb);
  data->category_count= mrb_hash_new(mrb);
  data->word_count= mrb_hash_new(mrb);
  DATA_PTR(self) = data;

  return self;
}

static mrb_value
mrb_naivebayes_vocabularies(mrb_state *mrb, mrb_value self)
{
  mrb_naivebayes_data *data;
  data = (mrb_naivebayes_data *)DATA_PTR(self);
  return data->vocabularies;
}

static mrb_value
mrb_naivebayes_category_count(mrb_state *mrb, mrb_value self)
{
  mrb_naivebayes_data *data;
  data = (mrb_naivebayes_data *)DATA_PTR(self);
  return data->category_count;
}

static mrb_value
mrb_naivebayes_word_count(mrb_state *mrb, mrb_value self)
{
  mrb_naivebayes_data *data;
  data = (mrb_naivebayes_data *)DATA_PTR(self);
  return data->word_count;
}

void mrb_mruby_naivebayes_init(mrb_state *mrb, struct RClass *mod)
{
    struct RClass *naivebayes;
    naivebayes = mrb_define_class_under(mrb, mod, "NaiveBayes", mrb->object_class);
    mrb_define_method(mrb, naivebayes, "initialize", mrb_naivebayes_initialize, MRB_ARGS_NONE());
    mrb_define_method(mrb, naivebayes, "vocabularies", mrb_naivebayes_vocabularies, MRB_ARGS_NONE());
    mrb_define_method(mrb, naivebayes, "category_count", mrb_naivebayes_category_count, MRB_ARGS_NONE());
    mrb_define_method(mrb, naivebayes, "word_count", mrb_naivebayes_word_count, MRB_ARGS_NONE());


}
