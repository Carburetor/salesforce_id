#include "insensitive_to_sensitive.h"
#include "ruby.h"
#include <string.h>
#include "salesforce_id_ext.h"
#include "repair_casing.h"

// rb_sId MUST be a string and of size 18
VALUE insensitive_to_sensitive(VALUE rb_sId)
{
  const int   new_id_size         = SALESFORCE_ID_INSENSITIVE_LENGTH + 1;
        char* id                  = StringValueCStr(rb_sId);
        char  new_id[SALESFORCE_ID_INSENSITIVE_LENGTH + 1] = {0};

  memcpy(new_id, id, new_id_size);
  repair_casing(new_id);
  memset(&new_id[15], 0, sizeof(new_id[0]) * 4u);

  return rb_str_new2(new_id);
}
