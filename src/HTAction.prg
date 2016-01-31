/*
 *
 *
 */

#include "hbtui.ch"

CLASS HAction FROM HObject
PROTECTED:
    DATA FisSeparator INIT .f.
PUBLIC:

    CONSTRUCTOR new( ... )

    METHOD isSeparator() INLINE ::FisSeparator
    METHOD setSeparator( b ) INLINE ::FisSeparator := b
    METHOD setShortcut( shortcut )
    METHOD setText( text ) INLINE ::Ftext := text

    PROPERTY shortcut
    PROPERTY text

ENDCLASS

/*
    new
*/
METHOD new( ... ) CLASS HAction
    LOCAL version := 0
    LOCAL parent
    LOCAL text

    IF pCount() = 1
        parent := hb_pValue( 1 )
        IF hb_isObject( parent ) .AND. parent:isDerivedFrom("HObject")
            version := 1
        ENDIF
    ENDIF

    IF pCount() = 2
        text := hb_pValue( 1 )
        parent := hb_pValue( 2 )
        IF hb_isChar( text ) .AND. hb_isObject( parent ) .AND. parent:isDerivedFrom("HObject")
            version := 2
        ENDIF
    ENDIF

    SWITCH version
    CASE 1
        ::super:new( parent )
        EXIT
    CASE 2
        ::setText( text )
        ::super:new( parent )
        EXIT
    OTHERWISE
        ::PARAM_ERROR()
    ENDSWITCH

RETURN self

/*
    setShortcut
*/
METHOD PROCEDURE setShortcut( shortcut ) CLASS HAction
    ::Fshortcut := shortcut
RETURN
