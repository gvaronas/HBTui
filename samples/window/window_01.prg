/*
 *
 */

#include "hbtui.ch"

CLASS MainWindow FROM HTMainWindow
PROTECTED:
PUBLIC:
ENDCLASS

PROCEDURE Main()
    LOCAL app
    LOCAL win

    SetMode( 40, 100 )

    app := HTApplication():new()

    win := MainWindow():new()

    win:show()

    app:exec()

RETURN
