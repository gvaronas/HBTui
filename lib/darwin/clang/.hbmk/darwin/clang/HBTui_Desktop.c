/*
 * Harbour 3.2.0dev (r1412151448)
 * LLVM/Clang C 6.0 (clang-600.0.56) (64-bit)
 * Generated C source from "src/HBTui_Desktop.prg"
 */

#include "hbvmpub.h"
#include "hbpcode.h"
#include "hbinit.h"
#include "hbxvm.h"


HB_FUNC( HBTUI_DESKTOP );
HB_FUNC_EXTERN( HB_THREADONCE );
HB_FUNC_STATIC( __S_HBTUI_DESKTOP );
HB_FUNC_EXTERN( __CLSLOCKDEF );
HB_FUNC_EXTERN( HBCLASS );
HB_FUNC_EXTERN( HBTUI_WIDGET );
HB_FUNC_EXTERN( __CLSUNLOCKDEF );
HB_FUNC_EXTERN( __OBJHASMSG );
HB_FUNC_EXTERN( __DBGENTRY );
HB_FUNC_INITSTATICS();
HB_FUNC_INITLINES();


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_HBTUI_DESKTOP )
{ "HBTUI_DESKTOP", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( HBTUI_DESKTOP )}, NULL },
{ "HB_THREADONCE", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_THREADONCE )}, NULL },
{ "__S_HBTUI_DESKTOP", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( __S_HBTUI_DESKTOP )}, NULL },
{ "__CLSLOCKDEF", {HB_FS_PUBLIC}, {HB_FUNCNAME( __CLSLOCKDEF )}, NULL },
{ "NEW", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "HBCLASS", {HB_FS_PUBLIC}, {HB_FUNCNAME( HBCLASS )}, NULL },
{ "HBTUI_WIDGET", {HB_FS_PUBLIC}, {HB_FUNCNAME( HBTUI_WIDGET )}, NULL },
{ "CREATE", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "__CLSUNLOCKDEF", {HB_FS_PUBLIC}, {HB_FUNCNAME( __CLSUNLOCKDEF )}, NULL },
{ "INSTANCE", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "__OBJHASMSG", {HB_FS_PUBLIC}, {HB_FUNCNAME( __OBJHASMSG )}, NULL },
{ "INITCLASS", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "__DBGENTRY", {HB_FS_PUBLIC}, {HB_FUNCNAME( __DBGENTRY )}, NULL },
{ "(_INITSTATICS00003)", {HB_FS_INITEXIT | HB_FS_LOCAL}, {hb_INITSTATICS}, NULL },
{ "(_INITLINES)", {HB_FS_INITEXIT | HB_FS_LOCAL}, {hb_INITLINES}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_HBTUI_DESKTOP, "src/HBTui_Desktop.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_HBTUI_DESKTOP
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_HBTUI_DESKTOP )
   #include "hbiniseg.h"
#endif

HB_FUNC( HBTUI_DESKTOP )
{
   HB_BOOL fValue;
   do {
	hb_xvmSFrame( symbols + 13 );
	hb_xvmModuleName( "src/HBTui_Desktop.prg:HBTUI_DESKTOP" );
	hb_xvmSetLine( 7 );
	hb_xvmStaticName( 0, 1, "OBJ" );
	hb_xvmStaticName( 0, 2, "ONCE" );
	hb_xvmSetLine( 7 );
	hb_xvmPushStatic( 1 );
	hb_xvmPushNil();
	if( hb_xvmExactlyEqual() ) break;
	if( hb_xvmPopLogical( &fValue ) ) break;
	if( ! fValue )
		goto lab00001;
	hb_xvmPushFuncSymbol( symbols + 1 );
	hb_xvmPushStaticByRef( 2 );
	{
		static const HB_BYTE codeblock[ 47 ] = {
			51, 115, 114, 99, 47, 72, 66, 84, 117, 105, 95, 68, 101, 115, 107, 116, 
			111, 112, 46, 112, 114, 103, 58, 72, 66, 84, 85, 73, 95, 68, 69, 83, 
			75, 84, 79, 80, 0, 176, 2, 0, 12, 0, 165, 82, 1, 0, 6 };
		hb_xvmPushBlockShort( codeblock, symbols );
	}
	if( hb_xvmDo( 2 ) ) break;
lab00001: ;
	hb_xvmSetLine( 7 );
	hb_xvmPushStatic( 1 );
	hb_xvmRetValue();
	/* *** END PROC *** */
   } while( 0 );
}

HB_FUNC_STATIC( __S_HBTUI_DESKTOP )
{
   HB_BOOL fValue;
   do {
	hb_xvmVFrame( 3, 0 );
	hb_xvmSFrame( symbols + 13 );
	hb_xvmModuleName( "src/HBTui_Desktop.prg:__S_HBTUI_DESKTOP" );
	hb_xvmSetLine( 7 );
	hb_xvmStaticName( 0, 3, "S_OCLASS" );
	hb_xvmLocalName( 1, "NSCOPE" );
	hb_xvmLocalName( 2, "OCLASS" );
	hb_xvmLocalName( 3, "OINSTANCE" );
	hb_xvmPushStatic( 3 );
	hb_xvmPushNil();
	if( hb_xvmExactlyEqual() ) break;
	if( hb_xvmPopLogical( &fValue ) ) break;
	if( ! fValue )
		goto lab00002;
	hb_xvmPushFuncSymbol( symbols + 3 );
	hb_xvmPushStaticByRef( 3 );
	if( hb_xvmFunction( 1 ) ) break;
	if( hb_xvmPopLogical( &fValue ) ) break;
	if( ! fValue )
		goto lab00002;
	hb_xvmSeqAlways();
	do {
	hb_xvmLocalSetInt( 1, 1 );
	hb_xvmPushSymbol( symbols + 4 );
	hb_xvmPushFuncSymbol( symbols + 5 );
	if( hb_xvmFunction( 0 ) ) break;
	hb_xvmPushStringConst( "HBTui_Desktop", 13 );
	hb_xvmPushSymbol( symbols + 6 );
	hb_xvmArrayGen( 1 );
	hb_xvmPushSymbol( symbols + 2 );
	if( hb_xvmSend( 3 ) ) break;
	hb_xvmPopLocal( 2 );
	hb_xvmSetLine( 8 );
	hb_xvmLocalSetInt( 1, 2 );
	hb_xvmSetLine( 9 );
	hb_xvmLocalSetInt( 1, 1 );
	hb_xvmSetLine( 10 );
	hb_xvmPushSymbol( symbols + 7 );
	hb_xvmPushLocal( 2 );
	if( hb_xvmSend( 0 ) ) break;
	hb_stackPop();
	} while( 0 );
	if( hb_xvmAlwaysBegin() ) break;
	do {
	hb_xvmPushFuncSymbol( symbols + 8 );
	hb_xvmPushStaticByRef( 3 );
	hb_xvmPushLocal( 2 );
	if( hb_xvmDo( 2 ) ) break;
	} while( 0 );
	if( hb_xvmAlwaysEnd() ) break;
	hb_xvmPushSymbol( symbols + 9 );
	hb_xvmPushLocal( 2 );
	if( hb_xvmSend( 0 ) ) break;
	hb_xvmPopLocal( 3 );
	hb_xvmPushFuncSymbol( symbols + 10 );
	hb_xvmPushLocal( 3 );
	hb_xvmPushStringConst( "InitClass", 9 );
	if( hb_xvmFunction( 2 ) ) break;
	if( hb_xvmPopLogical( &fValue ) ) break;
	if( ! fValue )
		goto lab00001;
	hb_xvmPushSymbol( symbols + 11 );
	hb_xvmPushLocal( 3 );
	hb_xvmPushVParams();
	if( hb_xvmMacroSend( 1 ) ) break;
	hb_stackPop();
lab00001: ;
	hb_xvmPushLocal( 3 );
	hb_xvmRetValue();
	/* *** END PROC *** */
	break;
lab00002: ;
	hb_xvmPushSymbol( symbols + 9 );
	hb_xvmPushStatic( 3 );
	if( hb_xvmSend( 0 ) ) break;
	hb_xvmRetValue();
	/* *** END PROC *** */
   } while( 0 );
}

HB_FUNC_INITSTATICS()
{
   do {
	hb_xvmStatics( symbols + 13, 3 );
	hb_xvmSFrame( symbols + 13 );
	hb_xvmModuleName( "src/HBTui_Desktop.prg:(_INITSTATICS)" );
	/* *** END PROC *** */
   } while( 0 );
}

HB_FUNC_INITLINES()
{
   do {
	hb_xvmModuleName( "src/HBTui_Desktop.prg:(_INITLINES)" );
	hb_xvmPushStringConst( "src/HBTui_Desktop.prg", 21 );
	hb_xvmPushInteger( 0 );
	hb_xvmPushStringConst( "\x80\x07", 2 );
	hb_xvmArrayGen( 3 );
	hb_xvmArrayGen( 1 );
	hb_xvmRetValue();
	/* *** END PROC *** */
   } while( 0 );
}

