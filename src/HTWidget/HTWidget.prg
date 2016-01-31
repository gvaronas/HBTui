/*
 *
 */

#include "hbtui.ch"
#include "inkey.ch"

#define _DESKTOP_COLOR  "03/01"
#define _DESKTOP_CHAR   e"\xB1"
#define _WIDGET_COLOR   "11/09"
#define _WIDGET_CHAR    e"\x20"
#define _WIDGET_SHADOW  8

CLASS HWidget FROM HObject
PROTECTED:

    DATA Factions
    DATA FAsDesktopWidget
    DATA FbtnClosePos
    DATA FBtnHidePos
    DATA FbtnMaximizePos
    DATA FbtnResizePos
    DATA FclearA    INIT "07/15"
    DATA FclearB    INIT _DESKTOP_CHAR
    DATA Fcolor
    DATA FposDown
//    DATA FposUp
    DATA Fshadow    INIT _WIDGET_SHADOW
    DATA FwindowId  /* CT Handle */
    DATA FwinSysBtnMove     INIT .f.
    DATA FwinSysBtnClose    INIT .f.
    DATA FwinSysBtnHide     INIT .f.
    DATA FwinSysBtnMaximize INIT .f.
    DATA FwinSysBtnResize   INIT .f.

    METHOD displayLayout()
    METHOD getClearA INLINE ::FclearA
    METHOD getClearB INLINE ::FclearB
    METHOD getColor
    METHOD getPos() INLINE HPoint():new( ::y, ::x )
    METHOD getShadow INLINE ::Fshadow
    METHOD getWindowId()
    METHOD paintChildren()
    METHOD paintTopLevelWindow()
    METHOD setClearA( clearA ) INLINE ::FclearA := clearA
    METHOD setClearB( clearB ) INLINE ::FclearB := clearB
    METHOD SetColor( color ) INLINE ::Fcolor := color
    METHOD setShadow( shadow ) INLINE ::Fshadow := shadow
    METHOD setWindowId( windowId )

PUBLIC:

    CONSTRUCTOR new( ... )

    METHOD actions()
    METHOD addAction( action )
    METHOD addEvent( event, priority )

    METHOD closeEvent( closeEvent )
    METHOD event( event )
    METHOD focusInEvent( eventFocus )
    METHOD focusOutEvent( eventFocus )
    METHOD keyEvent( keyEvent )
    METHOD mouseEvent( eventMouse )
    METHOD move( ... )
    METHOD moveEvent( moveEvent )
    METHOD paintEvent( event )
    METHOD repaint()
    METHOD resize( ... )
    METHOD resizeEvent( event )

    METHOD setAsDesktopWidget
    METHOD setBackgroundColor( color )
    METHOD setFocus()
    METHOD setForegroundColor( color )
    METHOD setLayout( layout )
    METHOD setWindowFlags( type ) INLINE ::FwindowFlags := type
    METHOD setWindowTitle( title )

    METHOD show()
    METHOD showEvent( showEvent )

    METHOD windowType() INLINE hb_bitAnd( ::windowFlags, 0x000000ff )

    PROPERTY backgroundColor WRITE setBackgroundColor
    PROPERTY charWidgetClose    INIT hb_BChar( 254 )
    PROPERTY charWidgetHide     INIT hb_BChar( 254 )
    PROPERTY charWidgetMaximize INIT hb_BChar( 254 )
    PROPERTY charWidgetResize INIT "<>" //Chr( 254 )
    PROPERTY clearA READ getClearA WRITE setClearA
    PROPERTY clearB READ getClearB WRITE setClearB
    PROPERTY color READ getColor WRITE SetColor
    PROPERTY foregroundColor WRITE setForegroundColor
    PROPERTY height INIT 0
    PROPERTY isVisible INIT .f.
    PROPERTY layout WRITE setLayout
    PROPERTY pos READ getPos()
    PROPERTY shadow READ getShadow WRITE setShadow
    PROPERTY size
    PROPERTY width INIT 0
    PROPERTY windowFlags INIT 0
    PROPERTY windowId READ getWindowId WRITE setWindowId /* only main windows have it */
    PROPERTY windowTitle INIT ""
    PROPERTY x INIT 0
    PROPERTY y INIT 0

    /* */

    PROPERTY posUp

    /* */

ENDCLASS

/*
    new
*/
METHOD new( ... ) CLASS HWidget
    LOCAL version := 0
    LOCAL parent
    LOCAL f

    ::Factions := {}

    IF pCount() <= 2
        parent := hb_pValue( 1 )
        f := hb_pValue( 2 )
        IF parent == NIL .OR. hb_isObject( parent )
            version := 1
        ENDIF
    ENDIF

    SWITCH version
    CASE 1
        ::super:new( parent )
        ::setWindowFlags( f )
        EXIT
    OTHERWISE
        ::PARAM_ERROR()
    ENDSWITCH

RETURN self

/*
    actions
*/
METHOD FUNCTION actions() CLASS HWidget

RETURN ::Factions

/*
    addAction
*/
METHOD PROCEDURE addAction( action ) CLASS HWidget
    IF aScan( ::Factions, action ) = 0
        aAdd( ::Factions, action )
    ENDIF
RETURN

/*
    addEvent
*/
METHOD PROCEDURE addEvent( event, priority ) CLASS HWidget
    event:setWidget( self )
    HApplication():queueEvent( event, priority )
RETURN

/*
    closeEvent
*/
METHOD PROCEDURE closeEvent( closeEvent ) CLASS HWidget
    closeEvent:accept()
    IF ::FwindowId != NIL
        WClose( ::FwindowId )
    ENDIF
RETURN

/*
    displayLayout
*/
METHOD PROCEDURE displayLayout() CLASS HWidget
    LOCAL itm

    FOR EACH itm IN ::Flayout
    NEXT

RETURN

/*
    event
*/
METHOD FUNCTION event( event ) CLASS HWidget
    LOCAL parent

    SWITCH event:type
    CASE HT_EVENT_TYPE_CLOSE
        ::closeEvent( event )
        EXIT
    CASE HT_EVENT_TYPE_FOCUSIN
        ::focusInEvent( event )
        EXIT
    CASE HT_EVENT_TYPE_FOCUSOUT
        ::focusOutEvent( event )
        EXIT
    CASE HT_EVENT_TYPE_KEYBOARD
        ::keyEvent( event )
        EXIT
    CASE HT_EVENT_TYPE_MOUSE
        ::mouseEvent( event )
        EXIT
    CASE HT_EVENT_TYPE_MOVE
        ::moveEvent( event )
        EXIT
    CASE HT_EVENT_TYPE_PAINT
        ::paintEvent( event )
        EXIT
    CASE HT_EVENT_TYPE_RESIZE
        ::resizeEvent( event )
        EXIT
    CASE HT_EVENT_TYPE_SHOW
        ::showEvent( event )
        EXIT
    OTHERWISE
        RETURN ::super:event( event )
    ENDSWITCH

    parent := ::parent()

    IF ! event:isAccepted() .AND. parent != NIL
        RETURN parent:event( event )
    ENDIF

RETURN event:accept()

/*
    focusInEvent
*/
METHOD PROCEDURE focusInEvent( eventFocus ) CLASS HWidget
    eventFocus:accept()
    IF eventFocus:isAccepted()
        wSelect( ::windowId )
        IF MLeftDown()
            ::addEvent( HMouseEvent():new( K_LBUTTONDOWN ) )
        ENDIF
    ENDIF
RETURN

/*
    focusOutEvent
*/
METHOD PROCEDURE focusOutEvent( eventFocus ) CLASS HWidget
    IF eventFocus:isAccepted()

    ENDIF
RETURN

/*
    getColor
*/
METHOD FUNCTION getColor CLASS HWidget
    LOCAL parent

    IF ::Fcolor != NIL
        RETURN ::Fcolor
    ELSE
        parent := ::parent()
        IF parent != NIL
            RETURN parent:Color
        ENDIF
    ENDIF
RETURN iif( ::FAsDesktopWidget = .t., _DESKTOP_COLOR, _WIDGET_COLOR )

/*
    getWindowId
*/
METHOD FUNCTION getWindowId() CLASS HWidget
    LOCAL parent := ::parent()
    IF ::FwindowId = NIL .AND. parent != NIL
        RETURN parent:windowId
    ENDIF
RETURN ::FwindowId

/*
    keyEvent
*/
METHOD PROCEDURE keyEvent( keyEvent ) CLASS HWidget
    HB_SYMBOL_UNUSED( keyEvent )
RETURN

/*
    mouseEvent
*/
METHOD PROCEDURE mouseEvent( eventMouse ) CLASS HWidget
    LOCAL x
    LOCAL y

    SWITCH eventMouse:nKey
    CASE K_LBUTTONDOWN

        ::FposUp := NIL
        ::FposDown := HPoint():new( eventMouse:mouseCol, eventMouse:mouseRow )

        ::FwinSysBtnClose := ::FbtnClosePos != NIL .AND. ::FposDown:y = 0 .AND. ::FposDown:x >= ::FbtnClosePos[ 1 ] .AND. ::FposDown:x <= ::FbtnClosePos[ 2 ]

        ::FwinSysBtnHide := ::FBtnHidePos != NIL .AND. ::FposDown:y = 0 .AND. ::FposDown:x >= ::FBtnHidePos[ 1 ] .AND. ::FposDown:x <= ::FBtnHidePos[ 2 ]

        ::FwinSysBtnMaximize := ::FbtnMaximizePos != NIL .AND. ::FposDown:y = 0 .AND. ::FposDown:x >= ::FbtnMaximizePos[ 1 ] .AND. ::FposDown:x <= ::FbtnMaximizePos[ 2 ]

        ::FwinSysBtnResize := ::FbtnResizePos != NIL .AND. ::FposDown:y = ( ::Fheight - 1 ) .AND. ::FposDown:x >= ::FbtnResizePos[ 1 ] .AND. ::FposDown:x <= ::FbtnResizePos[ 2 ]

        IF ::FposDown:y = 0 .AND. ! ::FwinSysBtnClose .AND. ! ::FwinSysBtnHide .AND. ! ::FwinSysBtnMaximize .AND. ! ::FwinSysBtnResize
            ::FwinSysBtnMove := .t.
        ENDIF

        OutStd( ::FposDown:x, ::FposDown:y, e"\n" )

        IF HApplication():activeWindow() = NIL .OR. HApplication():activeWindow():windowId != ::windowId
            ::addEvent( HFocusEvent():new( HT_EVENT_TYPE_FOCUSIN ) )
        ENDIF

        EXIT

    CASE K_LBUTTONUP

        ::FposDown := NIL
        ::FposUp := HPoint():new( eventMouse:mouseCol, eventMouse:mouseRow )

        /* Close Event */
        IF ::FposUp:y = 0 .AND. ::FwinSysBtnClose .AND. ::FposUp:x >= ::FbtnClosePos[ 1 ] .AND. ::FposUp:x <= ::FbtnClosePos[ 2 ]
            ::addEvent( HCloseEvent():new() )
        ENDIF

        /* Hide Event */
        IF ::FposUp:y = 0 .AND. ::FwinSysBtnHide .AND. ::FposUp:x >= ::FBtnHidePos[ 1 ] .AND. ::FposUp:x <= ::FBtnHidePos[ 2 ]
            ::addEvent( HHideEvent():new() )
        ENDIF

        /* Maximize Event */
        IF ::FposUp:y = 0 .AND. ::FwinSysBtnMaximize .AND. ::FposUp:x >= ::FbtnMaximizePos[ 1 ] .AND. ::FposUp:x <= ::FbtnMaximizePos[ 2 ]
            ::addEvent( HMaximizeEvent():new() )
        ENDIF

        ::FwinSysBtnMove     := .f.
        ::FwinSysBtnClose    := .f.
        ::FwinSysBtnHide     := .f.
        ::FwinSysBtnMaximize := .f.

        EXIT

    CASE K_MOUSEMOVE

        IF ::FposDown != NIL

            x := mCol( .t. ) - ( ::FposDown:x + 1 )
            y := mRow( .t. )

            IF MLeftDown()
                IF ::FwinSysBtnMove
                    ::move( HPoint():new( y, x ) )
                ELSEIF ::FwinSysBtnResize
                    ::addEvent( HResizeEvent():new() )
                ENDIF
            ENDIF

        ENDIF

    ENDSWITCH

RETURN

/*
    move
*/
METHOD PROCEDURE move( ... ) CLASS HWidget
    LOCAL version := 0
    LOCAL x
    LOCAL y
    LOCAL newPos
    LOCAL oldPos

    oldPos := HPoint():new( ::y, ::x )

    SWITCH pCount()
    CASE 1
        newPos := hb_pValue( 1 )
        IF hb_isObject( newPos ) .AND. newPos:classH = HPoint():classH
            version := 1
        ENDIF
        EXIT
    CASE 2
        x := hb_pValue( 1 )
        y := hb_pValue( 2 )
        IF hb_isNumeric( x ) .AND. hb_isNumeric( y )
            version := 2
            newPos := HPoint():new( y, x )
        ENDIF
        EXIT
    OTHERWISE
        ::PARAM_ERROR()
    ENDSWITCH

    SWITCH version
    CASE 1
    CASE 2
        IF ::FwindowId != NIL
            wSelect( ::FwindowId, .f. )
            wMove( newPos:y, newPos:x )
        ELSE
            ::Fx := newPos:x
            ::Fy := newPos:y
            ::repaint()
        ENDIF
        ::addEvent( HMoveEvent():new( newPos, oldPos ) )
        EXIT
    OTHERWISE
        ::PARAM_ERROR()
    ENDSWITCH

RETURN

/*
    moveEvent
*/
METHOD PROCEDURE moveEvent( moveEvent ) CLASS HWidget
    HB_SYMBOL_UNUSED( moveEvent )
RETURN

/*
    paintChildren
*/
METHOD PROCEDURE paintChildren() CLASS HWidget
    LOCAL menuBar := ht_objectFromId( ::FmenuBar )
    LOCAL child

    IF menuBar != NIL
        menuBar:repaint()
    ENDIF

    IF ::Flayout != NIL
        ::displayLayout()
    ELSE
        FOR EACH child IN ::Fchildren
            IF ! menuBar == child .AND. child:isDerivedFrom( "HWidget" )
                child:repaint()
            ENDIF
        NEXT
    ENDIF

RETURN

/*
    paintEvent
*/
METHOD PROCEDURE paintEvent( event ) CLASS HWidget

    HB_SYMBOL_UNUSED( event )

    /* no parent, widget has/is a top level window */
    IF ::FwindowId != NIL .OR. ( ::parent = NIL .AND. ::FwindowId = NIL )
        ::paintTopLevelWindow()
    ENDIF

    ::paintChildren()

RETURN

/*
    paintTopLevelWindow
*/
METHOD PROCEDURE paintTopLevelWindow() CLASS HWidget
    LOCAL n

    ::Fheight := 10
    ::Fwidth := 40

    IF ::Fx = NIL
        ::Fx := maxRow() / 2 - ::Fheight / 2
    ENDIF

    IF ::Fy = NIL
        ::Fy := maxCol() / 2 - ::Fwidth / 2
    ENDIF

    ::setWindowId( wOpen( ::Fx, ::Fy, ::Fx + ::Fheight - 1, ::Fy + ::Fwidth - 1, .t. ) )

    setClearB( _WIDGET_CHAR )
    wBox( NIL, ::color ) /* border window */
    wFormat()

    n := 1

    IF ::charWidgetClose = NIL
        ::FbtnClosePos := NIL
    ELSE
        ::FbtnClosePos := { n, n += len( ::charWidgetClose ) - 1 }
        dispOutAt( 0, n, ::charWidgetClose, "04/09" )
        ++n
    ENDIF

    IF ::charWidgetHide = NIL
        ::FBtnHidePos := NIL
    ELSE
        ::FBtnHidePos := { n, n += len( ::charWidgetHide ) - 1 }
        dispOutAt( 0, n, ::charWidgetHide, "14/09" )
        ++n
    ENDIF

    IF ::charWidgetMaximize = NIL
        ::FbtnMaximizePos := NIL
    ELSE
        ::FbtnMaximizePos := { n, n += len( ::charWidgetMaximize ) - 1 }
        dispOutAt( 0, n, ::charWidgetMaximize, "02/09" )
        ++n
    ENDIF

    IF ::charWidgetResize = NIL
        ::FbtnResizePos := NIL
    ELSE
        n := len( ::charWidgetResize )
        ::FbtnResizePos := { ::Fwidth - n, ::Fwidth }
        dispOutAt( ::Fheight - 1, ::FbtnResizePos[ 1 ], ::charWidgetResize, ::color )
    ENDIF

    wFormat()

RETURN

/*
    repaint
*/
METHOD PROCEDURE repaint() CLASS HWidget
    ::paintEvent()
RETURN

/*
    resize
*/
METHOD PROCEDURE resize( ... ) CLASS HWidget
    LOCAL eventResize
    SWITCH pCount()
    CASE 2
        eventResize := HResizeEvent():new( HSize():new( hb_pValue( 1 ), hb_pValue( 2 ) ), ::size )
        EXIT
    CASE 1
        eventResize := HResizeEvent():new( hb_pValue( 1 ), ::size )
        EXIT
    ENDSWITCH
    IF eventResize != NIL
        ::addEvent( eventResize )
    ENDIF
RETURN

/*
    resizeEvent
*/
METHOD PROCEDURE resizeEvent( event ) CLASS HWidget
    HB_SYMBOL_UNUSED( event )
RETURN

/*
    setAsDesktopWidget
*/
METHOD PROCEDURE setAsDesktopWidget CLASS HWidget

    /* just one widget can be the desktop widget */
    IF ::FAsDesktopWidget = NIL .AND. HApplication():desktop = NIL
        ::FAsDesktopWidget := .t.
    ENDIF

RETURN

/*
    setBackgroundColor
*/
METHOD FUNCTION setBackgroundColor( color ) CLASS HWidget
    ::FbackgroundColor := color
RETURN ::FbackgroundColor

/*
    setFocus
*/
METHOD PROCEDURE setFocus() CLASS HWidget
    LOCAL activeWindow := HApplication():activeWindow()

    IF ! activeWindow == self
        IF activeWindow != NIL
            activeWindow:focusOutEvent( NIL )
        ENDIF
        ::focusInEvent( NIL )
    ENDIF

RETURN

/*
    setForegroundColor
*/
METHOD FUNCTION setForegroundColor( color ) CLASS HWidget
    ::FforegroundColor := color
RETURN ::FforegroundColor

/*
    setLayout
*/
METHOD PROCEDURE setLayout( layout ) CLASS HWidget
    IF ::Flayout = NIL
        ::Flayout := layout
    ENDIF
RETURN

/*
    setWindowId
*/
METHOD PROCEDURE setWindowId( windowId ) CLASS HWidget
    IF ::FwindowId = NIL
        ::FwindowId := windowId
        HApplication():addTopLevelWindow( windowId, self )
    ENDIF
RETURN

/*
    setWindowTitle
*/
METHOD PROCEDURE setWindowTitle( title ) CLASS HWidget
    ::FwindowTitle := title
RETURN

/*
    show
*/
METHOD PROCEDURE show() CLASS HWidget

    ::FisVisible := .t.

    ::addEvent( HPaintEvent():new() )
    ::addEvent( HFocusEvent():new( HT_EVENT_TYPE_FOCUSIN ) )
    ::addEvent( HShowEvent():new() )

RETURN

/*
    showEvent
*/
METHOD PROCEDURE showEvent( showEvent ) CLASS HWidget
    showEvent:accept()
RETURN

/*
    EndClass
*/
