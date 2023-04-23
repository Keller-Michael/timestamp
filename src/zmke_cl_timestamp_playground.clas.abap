CLASS zmke_cl_timestamp_playground DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
      INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zmke_cl_timestamp_playground IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA(timestamp) = zmke_cl_timestamp=>get_instance_with_current_ts( ).
    DATA(new_timestamp) = timestamp->add_days( 5 ).
  ENDMETHOD.

ENDCLASS.
