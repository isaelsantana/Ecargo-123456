<% @LANGUAGE = "VBSCRIPT"   %>
<%OPTION EXPLICIT           %>
<%'VERS: 000001				%>
<%'DATA: 18/11/2010			%>
<%'RESP: LUCAS ALVES        %>
<%
'

'************************************************************************************
Dim VntEmpresa_Id, VntUsuario_internet_id, VntGrupo_usuario_id
Dim VntBanco_Dados, VntNome_Produto, VntMsg_erro, VntMsg_Ret
Dim VntGrupo_Empresa_ID,VntFlag_Mult_Empresa, VntConecta_DB
Dim objLog, OutVntMsg_Ret, Retorno, control_form
Dim vntcont, outvntcusto_proposta_id

Dim vntcusto_proposta_id
Dim vntdata_validade_ini
Dim vntdata_validade_fim
Dim vntFlag_Custo
Dim vntMoeda
Dim vntFlag_Copia
Dim arrIDsValor

Dim arrvnt_valor_20, arrvnt_valor_40
Dim vntflag_Grava_Historico_Custo

If Session("usuario") = "" Then
	Session("msg_erro") = ""
	Response.Redirect "desconexao.asp"
End If

control_form = Request.Form("control_form")

Session("TEMP_custo_proposta_id") = Request.Form("txtcusto_proposta_id")
Session("TEMP_data_validade_ini") = Request.Form("txtdata_validade_ini")
Session("TEMP_data_validade_fim") = Request.Form("txtdata_validade_fim")
Session("TEMP_Flag_Custo")		  = Request.Form("optFlag_Custo")
Session("TEMP_Moeda")			  = Request.Form("optMoeda")
Session("TEMP_Flag_Copia")		  = Request.Form("txtFlag_Copia")
Session("TEMP_Flag_Grava_Historico_Custo") = Request.Form("txtFlag_Grava_Historico_Custo")

vntcusto_proposta_id = Session("TEMP_custo_proposta_id")
vntdata_validade_ini = Session("TEMP_data_validade_ini")
vntdata_validade_fim = Session("TEMP_data_validade_fim")
vntFlag_Custo		 = Session("TEMP_Flag_Custo")	
vntMoeda			 = Session("TEMP_Moeda")
vntFlag_Copia		 = Session("TEMP_Flag_Copia")
vntflag_Grava_Historico_Custo = Session("TEMP_Flag_Grava_Historico_Custo") 


REDIM arrvnt_valor_20 (4) 'Array dos valores de Container de 20'
REDIM arrvnt_valor_40 (4) 'Array dos valores de Container de 40'

REDIM arrIDsValor(8)
                
For vntcont = 0 to 3 'Armazena os Valores digitados no Array de 20'
    arrvnt_valor_20(vntcont) = Request.Form("txtcusto_proposta_valorL0C" & vntcont)
Next

For vntcont = 0 to 3 'Armazena os Valores digitados no Array de 40'
    arrvnt_valor_40(vntcont) = Request.Form("txtcusto_proposta_valorL1C" & vntcont)
Next

For vntcont = 0 to 7 'Armazena os IDs dos Valores digitados.
    arrIDsValor(vntcont) = Request.Form("txtarrIDsValor" & vntcont)
Next

Session("TEMP_ARR_valor_20") = arrvnt_valor_20
Session("TEMP_ARR_valor_40") = arrvnt_valor_40

Session("TEMP_arr_IDsValor") = arrIDsValor

VntEmpresa_id = SESSION("EMPRESA_ID")
VntUsuario_Internet_id = SESSION("GL_USUARIO_INTERNET_ID")
VntBanco_Dados = SESSION("NOME_BANCO")
VntGrupo_usuario_id = session("grupo_usuario_id")
vntNOME_PRODUTO = SESSION("NOME_PRODUTO")
VntFlag_Mult_Empresa = session("flag_mult_empresa")
Vntgrupo_empresa_id = session("grupo_empresa_id")
vntConecta_db = session("gl_conecta_db")

Session("GL_ASP_ORIGEM") = "CUSTOBAFCONTROL050.ASP"

Select Case control_form

	Case "G"
		Set objLog = Server.CreateObject("E050CBAF12.CBAF")
        If Trim(vntcusto_proposta_id) = "0" Or Trim(vntcusto_proposta_id) = ""  Then
            retorno = objLog.gGrava_Custo_Proposta(vntdata_validade_ini, vntdata_validade_fim, vntFlag_Custo, _
                              vntMoeda, arrvnt_valor_20, arrvnt_valor_40, arrIDsValor, _
                              vntUsuario_Internet_id, vntConecta_db, vntBanco_Dados, outvntMsg_Ret, outvntcusto_proposta_id)		   
    		
		    If Trim(retorno) > "0" Then
			    Session("MSG_ERRO") = outvntMsg_Ret
			    Session("MSG_AVISO") = ""
		        Response.Redirect "CUSTOBAFCAD050.ASP"
		    End If

			if trim(vntflag_Grava_Historico_Custo) = "S" then 
				retorno = objLog.gGrava_Historico_Custo_Proposta(vntdata_validade_ini, vntdata_validade_fim, vntFlag_Custo, _
								vntMoeda, arrvnt_valor_20, arrvnt_valor_40, arrIDsValor, _
								vntUsuario_Internet_id, vntConecta_db, vntBanco_Dados, outvntMsg_Ret, outvntcusto_proposta_id)
				Set objLOG = Nothing
			end if 
    		
		    If Trim(retorno) > "0" Then
			    Session("MSG_ERRO") = outvntMsg_Ret
			    Session("MSG_AVISO") = ""
		        Response.Redirect "CUSTOBAFCAD050.ASP"
		    End If
		    
		    Session("TEMP_Flag_Copia") = "N"
            Session("MSG_ERRO") = ""
            Session("MSG_AVISO") = "Os custos de BAF foram incluídos com sucesso"
            Session("TEMP_custo_proposta_id") =  outvntcusto_proposta_id
            Session("TEMP_arr_IDsValor") = arrIDsValor
         	Response.Redirect "CUSTOBAFCAD050.ASP"
	
	    Else
	    
		    retorno = objLog.gAltera_Custo_Proposta(vntcusto_proposta_id, vntdata_validade_ini, vntdata_validade_fim, vntFlag_Custo, _
                    vntMoeda, arrIDsValor, arrvnt_valor_20, arrvnt_valor_40, vntUsuario_Internet_id, vntConecta_db, _
                    vntBanco_Dados, outvntMsg_Ret)		  
    		
		    If Trim(retorno) > "0" Then
			    Session("MSG_ERRO") = outvntMsg_Ret
			    Session("MSG_AVISO") = ""
		        Response.Redirect "CUSTOBAFCAD050.ASP"
		    End If

			if trim(vntflag_Grava_Historico_Custo) = "S" then 
				retorno = objLog.gGrava_Historico_Custo_Proposta(vntdata_validade_ini, vntdata_validade_fim, vntFlag_Custo, _
								vntMoeda, arrvnt_valor_20, arrvnt_valor_40, arrIDsValor, _
								vntUsuario_Internet_id, vntConecta_db, vntBanco_Dados, outvntMsg_Ret, vntcusto_proposta_id)
				Set objLOG = Nothing
			end if 
    		
		    If Trim(retorno) > "0" Then
			    Session("MSG_ERRO") = outvntMsg_Ret
			    Session("MSG_AVISO") = ""
		        Response.Redirect "CUSTOBAFCAD050.ASP"
		    End If

		    Session("TEMP_Flag_Copia") = "N"
            Session("MSG_ERRO") = ""
            Session("MSG_AVISO") = "Os custos de BAF foram alterados com sucesso"
            Response.Redirect "CUSTOBAFCAD050.ASP"
	    
	    End If

	Case "E"

        Set objLOG = Nothing
		Set objLog = Server.CreateObject("E050CBAF12.CBAF")

		retorno = objLog.gExclui_Custo_Proposta(vntConecta_db, vntBanco_Dados, vntUsuario_Internet_id, _
                vntcusto_proposta_id,outvntMsg_Ret )

		Set objLOG = Nothing
		If retorno > 0 Then
			Session("MSG_ERRO")  = outvntMsg_Ret
			Session("MSG_AVISO") = ""
		    Response.Redirect "CUSTOBAFCAD050.ASP"
		End If

        Session("MSG_ERRO") = ""
        Session("MSG_AVISO") = "Os custos de BAF foram excluídos com sucesso"
        Session("GL_ASP_ORIGEM") = "MENUPR.ASP"
		Response.Redirect "CUSTOBAFCAD050.ASP"
		
	Case "L"
		Session("gl_asp_origem") = "MENUPR.ASP"
		Response.Redirect "CUSTOBAFCAD050.asp"
	Case "V"
		Response.Redirect "menupr.asp"
	Case Else
		Session("msg_erro") = "Ação não tratada. Contacte o Administrador."
		Session("MSG_AVISO") = ""
		Response.Redirect "CUSTOBAFCAD050.ASP"

End Select

Response.Redirect "CUSTOBAFCAD050.ASP"

%>
