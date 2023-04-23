CLASS zmke_cl_timestamp DEFINITION PUBLIC FINAL CREATE PRIVATE.

  PUBLIC SECTION.
    DATA utc_long_timestamp TYPE utclong READ-ONLY.
    DATA short_timestamp TYPE timestamp READ-ONLY.
    DATA long_timestamp TYPE timestampl READ-ONLY.
    DATA system_date TYPE d READ-ONLY.
    DATA system_time TYPE t READ-ONLY.

    "! <p class="shorttext synchronized" lang="en">get instance with current time stamp</p>
    CLASS-METHODS get_instance_with_current_ts RETURNING VALUE(result) TYPE REF TO zmke_cl_timestamp.

    "! <p class="shorttext synchronized" lang="en">get instance with given time stamp</p>
    CLASS-METHODS get_instance_with_given_ts
      IMPORTING
        utc_long_timestamp TYPE utclong
      RETURNING
        VALUE(result)      TYPE REF TO zmke_cl_timestamp.

    METHODS constructor IMPORTING utc_long_timestamp TYPE utclong.

    METHODS add_days
      IMPORTING
        days          TYPE i
      RETURNING
        VALUE(result) TYPE REF TO zmke_cl_timestamp.

  PROTECTED SECTION.

  PRIVATE SECTION.
    METHODS convert_to_long_timestamp.
    METHODS convert_to_short_timestamp.
    METHODS convert_to_date_time.

ENDCLASS.



CLASS zmke_cl_timestamp IMPLEMENTATION.

  METHOD constructor.
    me->utc_long_timestamp = utc_long_timestamp.

    convert_to_short_timestamp( ).
    convert_to_long_timestamp( ).
    convert_to_date_time( ).
  ENDMETHOD.

  METHOD convert_to_long_timestamp.
    long_timestamp = cl_abap_tstmp=>utclong2tstmp( utc_long_timestamp ).
  ENDMETHOD.

  METHOD convert_to_short_timestamp.
    short_timestamp = cl_abap_tstmp=>utclong2tstmp_short( utc_long_timestamp ).
  ENDMETHOD.

  METHOD convert_to_date_time.
    TRY.
        cl_abap_utclong=>to_system_timestamp(
                           EXPORTING
                             utc_tstmp   = utc_long_timestamp
                           IMPORTING
                             system_date = system_date
                             system_time = system_time ).

      CATCH cx_sy_conversion_no_date_time.
        " error handling
    ENDTRY.
  ENDMETHOD.

  METHOD add_days.
    result = NEW #( utclong_add( val = utc_long_timestamp
                                 days = days ) ).
  ENDMETHOD.

  METHOD get_instance_with_current_ts.
    result = NEW #( utclong_current( ) ).
  ENDMETHOD.

  METHOD get_instance_with_given_ts.
    result = NEW #( utc_long_timestamp ).
  ENDMETHOD.

ENDCLASS.
