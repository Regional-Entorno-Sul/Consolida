Function main()
cls
set color to w+/b+
set century on
set date to british

? "-----------------------------------------------------------"
? "Consolida versao 0.2 - 13/03/2025                          "
? "Consolida as informacoes sobre Dengue.                     "
? "https://github.com/Regional-Entorno-Sul/Consolida          "
? "-----------------------------------------------------------"

set color to g+/

public cID := alltrim( HB_ArgV ( 1 ) )

if empty( cID ) = .T.
set color to r+/
? "Erro!"
? "Falta o argumento para execucao do executavel"
wait
quit
endif

delete file "c:\consolida\shape\molde1.dbf"
delete file "c:\consolida\shape\molde2.dbf"
delete file "c:\consolida\shape\molde3.dbf"
delete file "c:\consolida\shape\molde4.dbf"

? "Extraindo o arquivo dbf do arquivo zip..."
nArraySize := ADir( "c:\consolida\deng\" )
aName := Array( nArraySize )
ADir( ( "c:\consolida\deng\" ),aName )
for f = 1 to nArraySize
hb_UnzipFile( "c:\consolida\deng\" + aName[f] )
next
? "Arquivo zip:"
? "c:\consolida\deng\" + aName[1]

nArraySize2 := ADir( "c:\consolida\deng\*.dbf" )
aName2 := Array( nArraySize2 )
ADir( ( "c:\consolida\deng\*.dbf" ),aName2 )

? "Arquivo dbf:"
? ( "c:\consolida\deng\" + aName2[1] )

rename ( "c:\consolida\deng\" + aName2[1] ) to ("c:\consolida\deng\dengon.dbf")
copy file ("c:\consolida\deng\dengon.dbf") to ("c:\consolida\work\dengon.dbf")

? ""

if ( cID ) <> "--all"
use "c:\consolida\work\dengon.dbf"
delete for id_mn_resi = ( cID )
pack
close
endif

use "c:\consolida\deng\dengon.dbf"
do while .not. eof()
replace tp_not with ""
skip
enddo

if cID = "--all"
count to nSoro1 for alltrim( sorotipo ) = "1"
count to nSoro2 for alltrim( sorotipo ) = "2"
count to nSoro3 for alltrim( sorotipo ) = "3"
count to nSoro4 for alltrim( sorotipo ) = "4"
else
count to nSoro1 for alltrim( sorotipo ) = "1" .and. id_mn_resi = alltrim( cID )
count to nSoro2 for alltrim( sorotipo ) = "2" .and. id_mn_resi = alltrim( cID )
count to nSoro3 for alltrim( sorotipo ) = "3" .and. id_mn_resi = alltrim( cID )
count to nSoro4 for alltrim( sorotipo ) = "4" .and. id_mn_resi = alltrim( cID )
endif

? "Sorotipos para Dengue"
? "---------------------"
? "DENV-1:" + alltrim(str( nSoro1 ))
? "DENV-2:" + alltrim(str( nSoro2 ))
? "DENV-3:" + alltrim(str( nSoro3 ))
? "DENV-4:" + alltrim(str( nSoro4 ))

? ""

if cID = "--all"
count to notifics for sg_uf = "52"
else
count to notifics for sg_uf = "52" .and. id_mn_resi = alltrim( cID )
endif

? "Numero de casos notificados:" + alltrim(str( notifics ))
close

use "c:\consolida\deng\dengon.dbf"
replace tp_not with "X" for classi_fin = "10" .or. classi_fin = "11" .or. classi_fin = "12"

if cID = "--all"
count to confirmados for sg_uf = "52" .and. tp_not = "X"
else
count to confirmados for sg_uf = "52" .and. tp_not = "X" .and. id_mn_resi = alltrim( cID )
endif

? "Numero de casos confirmados:" + alltrim(str( confirmados ))

if cID = "--all"
count to lab for criterio = "1" .and. sg_uf = "52"
count to clin_epi for criterio = "2" .and. sg_uf = "52"
count to invest for criterio = "3" .and. sg_uf = "52"
else
count to lab for criterio = "1" .and. sg_uf = "52" .and. id_mn_resi = alltrim( cID )
count to clin_epi for criterio = "2" .and. sg_uf = "52" .and. id_mn_resi = alltrim( cID )
count to invest for criterio = "3" .and. sg_uf = "52" .and. id_mn_resi = alltrim( cID )
endif

? ""
? "Criterio laboratorial:" + alltrim( str( lab ) )
? "Criterio clinico epidemiologico:" + alltrim( str( clin_epi ))
? "Casos em investigacao:" + alltrim( str( invest ))

if cID = "--all"
count to nSexM for alltrim( cs_sexo ) = "M" .and. sg_uf = "52"
count to nSexF for alltrim( cs_sexo ) = "F" .and. sg_uf = "52"
else
count to nSexM for alltrim( cs_sexo ) = "M" .and. sg_uf = "52" .and. id_mn_resi = alltrim( cID )
count to nSexF for alltrim( cs_sexo ) = "F" .and. sg_uf = "52" .and. id_mn_resi = alltrim( cID )
endif

nSexTotal := nSexM + nSexF
nPercSexM := (nSexM * 100 ) / (nSexTotal)
nPercSexF := (nSexF * 100 ) / (nSexTotal)

? ""

if cID = "--all"
count to obito for evolucao = "2" .and. sg_uf = "52"
count to obito_invest for evolucao = "4" .and. sg_uf = "52"
count to descart for classi_fin = "5" .and. sg_uf = "52"
count to cura for evolucao = "1" .and. sg_uf = "52"
else 
count to obito for evolucao = "2" .and. sg_uf = "52" .and. id_mn_resi = alltrim( cID )
count to obito_invest for evolucao = "4" .and. sg_uf = "52" .and. id_mn_resi = alltrim( cID )
count to descart for classi_fin = "5" .and. sg_uf = "52" .and. id_mn_resi = alltrim( cID )
count to cura for evolucao = "1" .and. sg_uf = "52" .and. id_mn_resi = alltrim( cID )
endif 
 
? "Obitos:" + alltrim( str( obito ) )
? "Obitos em investigacao:" + alltrim( str( obito_invest ) )
? "Descartados:" + alltrim( str( descart ) )
? "Curados:" + + alltrim( str( cura ) )

? ""
? "Sexo dos casos notificados"
? "--------------------------"
? "Masculino:" + alltrim(str( nSexM )) + " (" + alltrim(str( nPercSexM )) + "%" + ")"
? "Feminino:" + alltrim(str( nSexF )) + " (" + alltrim(str( nPercSexF )) + "%" + ")"
? ""

close

use "c:\consolida\muns\list_muns.dbf"
zap
append from "c:\consolida\muns\list_muns.txt" delimited

	  public aArray_mun_list := {}
	  use "c:\consolida\muns\list_muns.dbf"
      nRecs := reccount()
      FOR x := 1 TO nRecs
	  AAdd( aArray_mun_list, {alltrim(cod_munres)} )
	  skip
	  NEXT
	  close

if cID = "--all"
use "c:\consolida\simaz\plan_simaz.dbf"
* ? "**********"
nTotalCasos := 0
nTotalBloq := 0
for loop_base = 1 to nRecs
* ? aArray_mun_list[loop_base,1]
locate for str( codigo_ibg ) = ( aArray_mun_list[loop_base,1] )
if found()
* ? codigo_ibg, qtd__casos, qtd__bloqu
nTotalCasos = nTotalCasos + qtd__casos
nTotalBloq = nTotalBloq + qtd__bloqu
endif
next
close

else

use "c:\consolida\simaz\plan_simaz.dbf"
* ? "**********"
nTotalCasos := 0
nTotalBloq := 0
locate for str( codigo_ibg ) = ( cID )
if found()
nTotalCasos = nTotalCasos + qtd__casos
nTotalBloq = nTotalBloq + qtd__bloqu
endif
close

endif

? "**********"
? "Total de casos notificados no SIMAZ: " + alltrim( str( nTotalCasos ))
? "Total de casos bloqueados no SIMAZ: " + alltrim( str( nTotalBloq ))

if cID = "--all"
use "c:\consolida\deng\dengon.dbf"
count to i_menor1 for nu_idade_n <= 4000 .and. sg_uf = "52"
count to i1_4 for nu_idade_n >= 4001 .and. nu_idade_n <= 4004 .and. sg_uf = "52"
count to i5_9 for nu_idade_n >= 4005 .and. nu_idade_n <= 4009 .and. sg_uf = "52"
count to i10_14 for nu_idade_n >= 4010 .and. nu_idade_n <= 4014 .and. sg_uf = "52"
count to i15_19 for nu_idade_n >= 4015 .and. nu_idade_n <= 4019 .and. sg_uf = "52"
count to i20_34 for nu_idade_n >= 4020 .and. nu_idade_n <= 4034 .and. sg_uf = "52"
count to i35_49 for nu_idade_n >= 4035 .and. nu_idade_n <= 4049 .and. sg_uf = "52"
count to i50_64 for nu_idade_n >= 4050 .and. nu_idade_n <= 4064 .and. sg_uf = "52"
count to i65_79 for nu_idade_n >= 4065 .and. nu_idade_n <= 4079 .and. sg_uf = "52"
count to i80 for nu_idade_n >= 4080 .and. sg_uf = "52"
else
use "c:\consolida\deng\dengon.dbf"
count to i_menor1 for nu_idade_n <= 4000 .and. sg_uf = "52" .and. id_mn_resi = alltrim( cID )
count to i1_4 for nu_idade_n >= 4001 .and. nu_idade_n <= 4004 .and. sg_uf = "52" .and. id_mn_resi = alltrim( cID )
count to i5_9 for nu_idade_n >= 4005 .and. nu_idade_n <= 4009 .and. sg_uf = "52" .and. id_mn_resi = alltrim( cID )
count to i10_14 for nu_idade_n >= 4010 .and. nu_idade_n <= 4014 .and. sg_uf = "52" .and. id_mn_resi = alltrim( cID )
count to i15_19 for nu_idade_n >= 4015 .and. nu_idade_n <= 4019 .and. sg_uf = "52" .and. id_mn_resi = alltrim( cID )
count to i20_34 for nu_idade_n >= 4020 .and. nu_idade_n <= 4034 .and. sg_uf = "52" .and. id_mn_resi = alltrim( cID )
count to i35_49 for nu_idade_n >= 4035 .and. nu_idade_n <= 4049 .and. sg_uf = "52" .and. id_mn_resi = alltrim( cID )
count to i50_64 for nu_idade_n >= 4050 .and. nu_idade_n <= 4064 .and. sg_uf = "52" .and. id_mn_resi = alltrim( cID )
count to i65_79 for nu_idade_n >= 4065 .and. nu_idade_n <= 4079 .and. sg_uf = "52" .and. id_mn_resi = alltrim( cID )
count to i80 for nu_idade_n >= 4080 .and. sg_uf = "52" .and. id_mn_resi = alltrim( cID )
endif

? ""
? "Faixa etaria"
? "------------"
? "< 1 ano ------------ " + alltrim( str( i_menor1 ))
? "1 a 4 -------------- " + alltrim( str( i1_4 ))
? "5 a 9 -------------- " + alltrim( str( i5_9 ))
? "10 a 14 ------------ " + alltrim( str( i10_14 ))
? "15 a 19 ------------ " + alltrim( str( i15_19 ))

? "20 a 34 ------------ " + alltrim( str( i20_34 ))
? "35 a 49 ------------ " + alltrim( str( i35_49 ))
? "50 a 64 ------------ " + alltrim( str( i50_64 ))
? "65 a 79 ------------ " + alltrim( str( i65_79 ))
? "80 e + ------------- " + alltrim( str( i80 ))

cMolde1 := ( "c:\consolida\shape\molde1.dbf" )
cMolde2 := ( "c:\consolida\shape\molde2.dbf" )
cMolde3 := ( "c:\consolida\shape\molde3.dbf" )
cMolde4 := ( "c:\consolida\shape\molde4.dbf" )
	
aStruct := { { "sorotipo1","N",6,0 }, ;
			 { "sorotipo2","N",6,0 }, ;
			 { "sorotipo3","N",6,0 }, ;
			 { "sorotipo4", "N", 6, 0 }, ;
			 { "notificado", "N", 8, 0 }, ;
			 { "confirmado", "N", 8, 0 }, ;
			 { "laboratori", "N", 8, 0 }, ;
			 { "clin_epide", "N", 8, 0 }, ;
			 { "investiga", "N", 8, 0 }, ;
			 { "obitos", "N", 8, 0 }} 
			 dbcreate (( cMolde1 ),aStruct )

use ( cMolde1 )
copy to ( cMolde2 )

* Acrescenta campos novos.
				use ( cMolde2 ) new
				aStruct2 := dbStruct( cMolde2 )
				AADD(aStruct2, { "obi_inv", "N", 8, 0 })			
				AADD(aStruct2, { "descartado", "N", 8, 0 }) 
				AADD(aStruct2, { "curados", "N", 8, 0 }) 
				AADD(aStruct2, { "masculino", "N", 8, 0 }) 
				AADD(aStruct2, { "feminino", "N", 8, 0 }) 
				AADD(aStruct2, { "percent_M", "N", 7, 2 }) 
				AADD(aStruct2, { "percent_F", "N", 7, 2 }) 
				AADD(aStruct2, { "not_simaz", "N", 8, 0 }) 
				AADD(aStruct2, { "bloq_simaz", "N", 8, 0 })	
				AADD(aStruct2, { "menor1", "N", 8, 0 }) 
				AADD(aStruct2, { "id_1a4", "N", 8, 0 }) 
				
				AADD(aStruct2, { "id_5a9", "N", 8, 0 }) 
				AADD(aStruct2, { "id_10a14", "N", 8, 0 }) 
				AADD(aStruct2, { "id_15a19", "N", 8, 0 }) 
				AADD(aStruct2, { "id_20a34", "N", 8, 0 }) 
				AADD(aStruct2, { "id_35a49", "N", 8, 0 }) 
				AADD(aStruct2, { "id_50a64", "N", 8, 0 }) 
				AADD(aStruct2, { "id_65a79", "N", 8, 0 }) 			
				AADD(aStruct2, { "id_80mais", "N", 8, 0 }) 
				
				dbCreate( (cMolde3 ) , aStruct2 )
close ( cMolde1 )

rename (cMolde3) to (cMolde4)

use "c:\consolida\shape\molde4.dbf"
zap
append blank
replace sorotipo1 with nSoro1
replace sorotipo2 with nSoro2
replace sorotipo3 with nSoro3
replace sorotipo4 with nSoro4
replace notificado with notifics
replace confirmado with confirmados
replace laboratori with lab
replace clin_epide with clin_epi
replace investiga with invest
replace obitos with obito
replace obi_inv with obito_invest
replace descartado with descart
replace curados with cura
replace masculino with nSexM
replace feminino with nSexF
replace percent_M with nPercSexM
replace percent_F with nPercSexF
replace not_simaz with nTotalCasos
replace bloq_simaz with nTotalBloq
replace menor1 with i_menor1
replace id_1a4 with i1_4
replace id_5a9 with i5_9
replace id_10a14 with i10_14
replace id_15a19 with i15_19
replace id_20a34 with i20_34
replace id_35a49 with i35_49
replace id_50a64 with i50_64
replace id_65a79 with i65_79
replace id_80mais with i80
close

cOrigem := "c:\consolida\shape\molde4.dbf"
cDestino := "c:\consolida\saida\molde4.dbf"
copy file ( cOrigem ) to ( cDestino )
cFile1 := "c:\consolida\saida\molde4.dbf"
cFile2 := "c:\consolida\saida\consolida_saida.dbf"
rename ( cFile1 ) to ( cFile2 )

return nil