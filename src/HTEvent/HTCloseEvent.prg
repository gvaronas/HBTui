/*
 *
 */

#include "hbtui.ch"

/*
    HTCloseEvent
*/
CLASS HTCloseEvent FROM HTEvent
PROTECTED:
    DATA Ftype INIT HT_EVENT_TYPE_CLOSE
PUBLIC:
    CONSTRUCTOR New()
ENDCLASS

/*
    New
*/
METHOD New() CLASS HTCloseEvent
RETURN Self