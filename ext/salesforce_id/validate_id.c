#include "validate_id.h"
#include "ruby.h"
#include <stdbool.h>
#include <string.h>
#include <stddef.h>
#include "salesforce_id.h"
#include "charmap.h"

// rb_sId MUST be a string
bool is_id_valid(VALUE rb_sId)
{
  VALUE id = rb_sId;

  if (RSTRING_LEN(id) == SALESFORCE_ID_SENSITIVE_LENGTH)   return true;
  if (RSTRING_LEN(id) == SALESFORCE_ID_INSENSITIVE_LENGTH) return true;

  return false;
}

bool has_valid_characters(VALUE rb_sId)
{
  char*  id      = StringValueCStr(rb_sId);
  size_t id_size = strlen(id);

  for (size_t index = 0u; index < id_size; ++index)
    if (charmap_index(id[index]) < 0) return false;

  return true;
}
