#ifndef SALESFORCE_ID_H
#define SALESFORCE_ID_H 1

#include "ruby.h"

extern VALUE rb_mSalesforceId;

#define SALESFORCE_ID_SENSITIVE_LENGTH          15
#define SALESFORCE_ID_INSENSITIVE_LENGTH        18
#define SALESFORCE_ID_SENSITIVE_STRING_LENGTH   16
#define SALESFORCE_ID_INSENSITIVE_STRING_LENGTH 19

/*
 * Entry point
 */
void Init_salesforce_id();

/*
 * Converts any valid salesforce ID to case-sensitive version
 * @param rb_sId [String] valid salesforce id
 * @return [String] salesforce id in case-sensitive version
 * @raise [ArgumentError] If ID contains invalid characters or it's not correct
 *   length
 */
VALUE salesforce_id_to_sensitive(VALUE self, VALUE rb_sId);

/*
 * Converts any valid salesforce ID to case-insensitive version
 * @param rb_sId [String] valid salesforce id
 * @return [String] salesforce id in case-insensitive version
 * @raise [ArgumentError] If ID contains invalid characters or it's not correct
 *   length
 */
VALUE salesforce_id_to_insensitive(VALUE self, VALUE rb_sId);

/*
 * Performs a deep check of the ID ensuring characters are all valid and length
 * is valid too
 * @param rb_sId [String] salesforce id (valid or not)
 * @return [Boolean] true if the deep check has success and salesforce id is
 *   valid
 */
VALUE salesforce_id_is_valid(VALUE self, VALUE rb_sId);

/*
 * Fixes a valid case-insensitive salesforce id casing by using the last 3
 * letters
 * @param rb_sId [String] valid salesforce id in case-insensitive format
 * @return [String] case-insensitive salesforce id with casing fixed, which
 *   means you can strip the last 3 characters to obtain the case-sensitive
 *   format
 * @raise [ArgumentError] If ID contains invalid characters or it's not correct
 *   length
 */
VALUE salesforce_insensitive_repair_casing(VALUE self, VALUE rb_sId);

/*
 * Detects if given ID is case-sensitive
 * @param rb_sId [String] salesforce id (valid or not)
 * @return [Boolean] true if passed ID is valid case-sensitive salesforce ID
 */
VALUE salesforce_id_is_sensitive(VALUE self, VALUE rb_sId);

/*
 * Detects if given ID is case-insensitive
 * @param rb_sId [String] salesforce id (valid or not)
 * @return [Boolean] true if passed ID is valid case-insensitive salesforce ID
 */
VALUE salesforce_id_is_insensitive(VALUE self, VALUE rb_sId);

#endif /* SALESFORCE_ID_H */
