#include "salesforce_id.h"
#include <string.h>
#include "repair_casing.h"
#include "insensitive_to_sensitive.h"
#include "sensitive_to_insensitive.h"
#include "validate_id.h"

VALUE rb_mSalesforceId;

void Init_salesforce_id()
{
  // Module
  rb_mSalesforceId = rb_define_module("SalesforceId");

  // Constants
  rb_define_const(
    rb_mSalesforceId,
    "SENSITIVE_SIZE",
    INT2FIX(SALESFORCE_ID_SENSITIVE_LENGTH)
  );
  rb_define_const(
    rb_mSalesforceId,
    "INSENSITIVE_SIZE",
    INT2FIX(SALESFORCE_ID_INSENSITIVE_LENGTH)
  );

  // Methods
  rb_define_method(
    rb_mSalesforceId,
    "to_sensitive",
    salesforce_id_to_sensitive,
    1
  );
  rb_define_method(
    rb_mSalesforceId,
    "to_insensitive",
    salesforce_id_to_insensitive,
    1
  );
  rb_define_method(
    rb_mSalesforceId,
    "valid?",
    salesforce_id_is_valid,
    1
  );
  rb_define_method(
    rb_mSalesforceId,
    "repair_casing",
    salesforce_insensitive_repair_casing,
    1
  );
}

// Convert to 15 character case-sensitive id
VALUE salesforce_id_to_sensitive(VALUE self, VALUE rb_sId)
{
  VALUE id = rb_obj_as_string(rb_sId);

  if (!is_id_valid(id))
  {
    rb_raise(rb_eArgError, "Invalid Salesforce ID");
    return Qnil;
  }

  if (RSTRING_LEN(id) == SALESFORCE_ID_SENSITIVE_LENGTH) return id;

  return insensitive_to_sensitive(id);
}

// Convert to 18 character case-insensitive id
VALUE salesforce_id_to_insensitive(VALUE self, VALUE rb_sId)
{
  VALUE id = rb_obj_as_string(rb_sId);

  if (!is_id_valid(id))
  {
    rb_raise(rb_eArgError, "Invalid Salesforce ID");
    return Qnil;
  }

  if (RSTRING_LEN(id) == SALESFORCE_ID_INSENSITIVE_LENGTH) return id;

  return sensitive_to_insensitive(id);
}

VALUE salesforce_id_is_valid(VALUE self, VALUE rb_sId)
{
  VALUE id = rb_obj_as_string(rb_sId);

  if (is_id_valid(id) && has_valid_characters(id)) return Qtrue;

  return Qfalse;
}

VALUE salesforce_insensitive_repair_casing(VALUE self, VALUE rb_sId)
{
  VALUE id = rb_obj_as_string(rb_sId);

  if (!is_id_valid(id))                                    return id;
  if (RSTRING_LEN(id) != SALESFORCE_ID_INSENSITIVE_LENGTH) return id;

  const int   new_id_size         = SALESFORCE_ID_INSENSITIVE_LENGTH + 1;
        char* old_id              = StringValueCStr(id);
        char  new_id[new_id_size] = {0};

  memcpy(new_id, old_id, new_id_size);
  repair_casing(new_id);

  return rb_str_new2(new_id);
}
