Function main()
cls
set color to g+/
set century on
set date to british

use "c:\consolida\deng\dengon.dbf"
do while .not. eof()
replace tp_not with ""
skip
enddo

count to nSoro1 for alltrim( sorotipo ) = "1"
count to nSoro2 for alltrim( sorotipo ) = "2"
count to nSoro3 for alltrim( sorotipo ) = "3"
count to nSoro4 for alltrim( sorotipo ) = "4"

? "Sorotipos para Dengue"
? "---------------------"
? "Sorotipo 1:" + alltrim(str( nSoro1 ))
? "Sorotipo 2:" + alltrim(str( nSoro2 ))
? "Sorotipo 3:" + alltrim(str( nSoro3 ))
? "Sorotipo 4:" + alltrim(str( nSoro4 ))

? ""

count to notifics for sg_uf = "52"
? "Numero de casos notificados:" + alltrim(str( notifics ))
close

use "c:\consolida\deng\dengon.dbf"
replace tp_not with "X" for classi_fin = "10" .or. classi_fin = "11" .or. classi_fin = "12"
count to confirmados for sg_uf = "52" .and. tp_not = "X"
? "Numero de casos confirmados:" + alltrim(str( confirmados ))

count to lab for criterio = "1" .and. sg_uf = "52"
count to clin_epi for criterio = "2" .and. sg_uf = "52"
count to invest for criterio = "3" .and. sg_uf = "52"

? ""
? "Criterio laboratorial:" + alltrim( str( lab ) )
? "Criterio clinico epidemiologico:" + alltrim( str( clin_epi ))
? "Casos em investigacao:" + alltrim( str( invest ))

count to nSexM for alltrim( cs_sexo ) = "M" .and. sg_uf = "52"
count to nSexF for alltrim( cs_sexo ) = "F" .and. sg_uf = "52"
nSexTotal := nSexM + nSexF
nPercSexM := (nSexM * 100 ) / (nSexTotal)
nPercSexF := (nSexF * 100 ) / (nSexTotal)

? ""

count to obito for evolucao = "2" .and. sg_uf = "52"
? "Obitos:" + alltrim( str( obito ) )

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

? "**********"
? "Total de casos notificados no SIMAZ: " + alltrim( str( nTotalCasos ))
? "Total de casos bloqueados no SIMAZ: " + alltrim( str( nTotalBloq ))

use "c:\consolida\deng\dengon.dbf"
count to i1_4 for nu_idade_n >= 4001 .and. nu_idade_n <= 4004 .and. sg_uf = "52"
? alltrim( str( i1_4 ))

? "Faixa etaria"
? "------------"



return nil