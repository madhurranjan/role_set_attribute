role_set_attribute
=================

Chef plugin to set role specific attribute

You can run it as:

knife role_set_attr [default/override] [ROLE] [ATTRIBUTE]('.' separated) [VALUE]

ATTRIBUTE Hierarchy needs to be separated by dots. Example:
If you want the attribute hierarchy to be :
['abc']['def']['foo'] = 10

you need to run this as:

knife role_set_attr default <Name of Role> abc.def.foo 10
