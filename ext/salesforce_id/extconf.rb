require "mkmf"

# CFLAGS   = $(CCDLFLAGS) $(cflags)  -fno-common -pipe $(ARCH_FLAG)
with_cflags("$(cflags) -std=c99 -fno-common -pipe") do
  create_makefile("salesforce_id/salesforce_id")
end
