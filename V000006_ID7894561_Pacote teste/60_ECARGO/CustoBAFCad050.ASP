<%@LANGUAGE = "VBSCRIPT"   %>
<%OPTION EXPLICIT           %>
<%'VERS: 000001				%>
<%'DATA: 18/11/2010			%>
<%'RESP: LUCAS ALVES     %>
<%

Dim objlog, retorno, VntConecta_db
Dim VntEmpresa_Id, VntUsuario_internet_id, VntGrupo_usuario_id, cor_habilitado
Dim VntBanco_Dados, VntNome_Produto, VntMsg_erro, VntMsg_Ret, Tamanho_Tela
Dim VntGrupo_Empresa_ID, VntFlag_Mult_Empresa, contador
Dim vntclausula_where, vntcont_linha, vntcont_coluna

Dim vntcusto_proposta_id
Dim vntdata_validade_ini
Dim vntdata_validade_fim
Dim vntFlag_Container
Dim vntFlag_Custo
Dim vntMoeda
Dim vntFlag_Copia
Dim arrIDsValor
Dim vntarrvntcusto_proposta_valor_20pes
Dim vntarrvntcusto_proposta_valor_40pes

Dim arrvntcusto_proposta_valor

Dim vntqtde_porto
Dim arrvntporto_id
Dim arrvntnome_porto
Dim i
Dim arrTab_Parametro_Sistema_ID, arrParametro, tamArrParametro , vntflag_Grava_Historico_Custo

Sub Limpa_Session()
    Session("TEMP_custo_proposta_id") = ""
    Session("TEMP_Flag_Custo") = ""
    Session("TEMP_Moeda") = ""
    Session("TEMP_data_validade_ini") = ""
    Session("TEMP_data_validade_fim") = ""
    Session("TEMP_ARR_valor_20") = ""
    Session("TEMP_ARR_valor_40") = ""
    Session("TEMP_Flag_Copia") = ""
    Session("TEMP_arr_IDsValor") = ""
	Session("TEMP_Flag_Grava_Historico_Custo") = ""
End Sub

If Session("usuario") = "" then
	Session("msg_erro") = ""
	Response.Redirect "desconexao.asp"
End If

VntEmpresa_id = Session("EMPRESA_ID")
VntUsuario_Internet_id = Session("GL_USUARIO_INTERNET_ID")
VntBanco_Dados = Session("NOME_BANCO")
VntGrupo_usuario_id = Session("grupo_usuario_id")
vntNOME_PRODUTO = Session("NOME_PRODUTO")
VntFlag_Mult_Empresa = Session("flag_mult_empresa")
Vntgrupo_empresa_id = Session("grupo_empresa_id")
vntConecta_db = Session("gl_conecta_db")
Tamanho_Tela = Session("GL_TAMANHO_TELA")
cor_habilitado = Session("GL_COR_HABILITADO")

if trim(Tamanho_Tela)="" then
    Tamanho_Tela="800"
end if

If Session("gl_asp_origem") = "MENUPR.ASP" THEN
	Call Limpa_Session()
End If

tamArrParametro = 1
redim arrTab_Parametro_Sistema_ID(tamArrParametro - 1)
arrTab_Parametro_Sistema_ID(0) = 15078	 'Habilitado grava historico baf e integracao baf


'
set OBJLOG = NOTHING
set OBJLOG = server.createobject ("ECRGER84.GER")
RETORNO = OBJLOG.gVerifica_Multi_Parametro(vntConecta_DB, VntEmpresa_id, session("gl_usuario_internet_id"), _ 
	session("nome_banco"), SESSION("Nome_Produto"), arrTab_Parametro_Sistema_ID, arrParametro, VntMsg_Ret, tamArrParametro)
IF RETORNO <> 0 THEN
	set OBJLOG = NOTHING
	SESSION("MSG_ERRO") = outvntmsg_ret
	RESPONSE.REDIRECT "SERVAGREG036CAD.ASP"
END IF
'
vntflag_Grava_Historico_Custo  = arrParametro(0)


set OBJLOG = Nothing
set objlog = Server.CreateObject ("SIGFUN39.SFUN")
'MONTA COMBO PORTO
retorno = objlog.gMonta_Combo_sqls (vntConecta_db, vntBanco_Dados, vntUsuario_Internet_id, _
        vntqtde_porto, arrvntnome_porto, arrvntporto_id, "PORTO", "PORTO_ID", _
				"NOME_PORTO", " WHERE TAB_STATUS_ID = 1 ", VntMsg_Ret) 
set OBJLOG = Nothing
if RETORNO <> 0 Then
	Session("MSG_ERRO") = VntMsg_Ret & " (PORTO) "
	Response.Redirect "MENUPR.ASP"
End If



If TRIM(UCASE(Session("gl_asp_origem"))) = "MENUPR.ASP"  or TRIM(UCASE(Session("gl_asp_origem"))) = "CUSTOBAFPESQ050.ASP" THEN
   
    redim vntarrvntcusto_proposta_valor_20pes(4)
    redim vntarrvntcusto_proposta_valor_40pes(4)
    Session("TEMP_ARR_valor_20") = vntarrvntcusto_proposta_valor_20pes
    Session("TEMP_ARR_valor_40") = vntarrvntcusto_proposta_valor_40pes
    redim arrIDsValor(8)
    Session("TEMP_arr_IDsValor") = arrIDsValor
    
End IF

Set objLOG = Nothing
Set objLog = Server.CreateObject("E050CBAF12.CBAF")

If trim(Request.QueryString("CUSTO_PROPOSTA_ID")) <> "" And trim(Request.QueryString("CUSTO_PROPOSTA_ID")) <> "0" Then
	vntcusto_proposta_id = trim(Request.QueryString("CUSTO_PROPOSTA_ID"))
End if 

If trim(vntcusto_proposta_id) > "0" then
	
    retorno = objLog.gConsulta_Custo_Proposta(vntcusto_proposta_id, vntdata_validade_ini, vntdata_validade_fim, _
            vntFlag_Custo, vntMoeda, arrIDsValor, vntarrvntcusto_proposta_valor_20pes, _
            vntarrvntcusto_proposta_valor_40pes, vntUsuario_Internet_id, vntConecta_db, vntBanco_Dados, VntMsg_Ret)
    
    Set objLOG = Nothing
	If retorno > 0 Then
		Session("MSG_ERRO") = VntMsg_Ret
		Session("gl_asp_origem") = "MENUPR.ASP"
	    Response.Redirect "CUSTOBAFCAD050.ASP"
	End If
	
	IF TRIM(Request.QueryString("FLAG_COPIA")) = "" OR TRIM(Request.QueryString("FLAG_COPIA")) = "N" THEN
	    vntFlag_Copia           = "N"
	ELSE
	    vntFlag_Copia           = "S"
	END IF
	
	if Trim(vntFlag_Copia)      = "S" then
		vntcusto_proposta_id    = ""
		vntdata_validade_ini    = ""
        vntdata_validade_fim    = ""
    end if
		
Else

    vntcusto_proposta_id = Session("TEMP_custo_proposta_id")
    vntdata_validade_ini = Session("TEMP_data_validade_ini")
    vntdata_validade_fim = Session("TEMP_data_validade_fim")
	vntFlag_Custo		 = Session("TEMP_Flag_Custo")
    vntMoeda			 = Session("TEMP_Moeda")
    
    IF TRIM(Session("TEMP_Flag_Copia")) = "" OR TRIM(Session("TEMP_Flag_Copia")) = "N" THEN
	    vntFlag_Copia           = "N"
	ELSE
	    vntFlag_Copia           = "S"
	END IF      
        
	if Trim(vntFlag_Copia)      = "S" then
		vntcusto_proposta_id    = ""
	end if
	
	vntarrvntcusto_proposta_valor_20pes = Session("TEMP_ARR_valor_20")
	vntarrvntcusto_proposta_valor_40pes = Session("TEMP_ARR_valor_40")
	arrIDsValor = Session("TEMP_arr_IDsValor")
	
End IF

Session("GL_ASP_ORIGEM") = "CUSTOBAFCAD050.ASP"
Session("GL_ASP_VOLTA") = "CUSTOBAFCAD050.ASP"

%>

<HTML>
<HEAD>
	<TITLE>Custos de BAF</TITLE>
	<!--#include FILE = "CONFIG.ASP"-->
	<script language="javascript" src="JavaScript7.js"></script>
    <script language="javascript" src="SelGer.js"></script>
    <style type="text/css">
	    .text_selger{background-color: <%=cor_habilitado%>;}
	    .calendario{border-width: 0px;}
    </style>
    <!--#include FILE = "MaskedCalendar.asp"-->
</HEAD>
<body <%=GL_CRFP()%> onload="SelGer.Ini('',1000);Focus();">
<center>
<br>
<table width="<%=Tamanho_Tela%>" align="center">
	<%If Session("msg_erro") <> "" then%>
		<tr><td align=center><%=GL_FMER(Session("msg_erro"))%></td></tr>
	<%End If%>
	<%If Session("msg_aviso") <> "" then%>
		<tr><td align=center><%=GL_FMAV(Session("msg_aviso"))%></td></tr>
	<%End If%>
	<%Session("msg_aviso") = ""%>
	<%Session("msg_erro") = ""%>
</table>

<table width="<%=Tamanho_Tela%>" align=center <%=GL_TITP()%>>
	<tr>
		<td align=center><%=GL_FTPG("Custos de BAF","")%></td>
	</tr>
</table>
<br />
<table width="<%=Tamanho_Tela%>" align="center" <%=GL_TIPG()%>>
<tr>
    <td align="center">
        <a href="CustoBafPesq050.ASP"><%=GL_FLIN("Pesquisar")%></a>
    </td>
	<% if trim(vntflag_Grava_Historico_Custo) = "S" and trim(vntcusto_proposta_id) <> "" then %>
		<td align="center"> 
			<a href="Vue/HistoricoBaf/index.html#/?id=<%=vntcusto_proposta_id%>"><%=GL_FLIN("Histórico Baf")%></a>
		</td>
	<%End if%>
</tr>
</table>

<br>
<form method="post" NAME="frmCadastro" action="CustoBafControl050.ASP">
<INPUT TYPE="HIDDEN" NAME="control_form" VALUE="G">
<INPUT TYPE="HIDDEN" NAME="versao" VALUE="18/11/2010 10:45">
<input type="hidden" name="txtcusto_proposta_id" value="<%=vntcusto_proposta_id%>">
<input type="hidden" name="txtFlag_Copia" value="<%=vntFlag_Copia%>">
<input type="hidden" name="txtFlag_Grava_Historico_Custo" value="<%=vntflag_Grava_Historico_Custo%>">

<%
    For i = 0 To 7
%>
        <input type="hidden" name="txtarrIDsValor<%=i%>" value="<%=arrIDsValor(i)%>">
<%
    Next
%>
<table width="<%=Tamanho_Tela%>" align=center <%=GL_TIPG()%>>
	<tr>
		<td><%=GL_FTCA("Identificador")%></td>
		<%if trim(vntFlag_Copia) = "S" then%>
			<td colspan=3><%=GL_FCTC("Novo")%></td>
		<%else%>
			<td colspan=3><%=GL_FCTC(vntcusto_proposta_id)%></td>
		<%end if%>
		<td><%=GL_FTCA("Validade De")%>
		<td>
			<input type="TEXT" size="10" name="txtdata_validade_ini" id="txtdata_validade_ini" value="<%=vntdata_validade_ini%>">
			<img id="imgCalendario_txtdata_validade_ini" class="MousePointer" src="images/Calendar_scheduleHS.png" class="calendario" />
            <span id="span_txtdata_validade_ini" class="consistencia"></span>
            <img id="imgBorracha_txtdata_validade_ini" class="MousePointer" onClick="limpaData('txtdata_validade_ini');" src="images/botao_borracha.jpg" />
		</td>
		<td><%=GL_FTCA("Até")%>
		</td>
		<td>
			<input type="TEXT" size="10" name="txtdata_validade_fim" id="txtdata_validade_fim" value="<%=vntdata_validade_fim%>">
			<img id="imgCalendario_txtdata_validade_fim" class="MousePointer" src="images/Calendar_scheduleHS.png" class="calendario" />
            <span id="span_txtdata_validade_fim" class="consistencia"></span>
            <img id="imgBorracha_txtdata_validade_fim" class="MousePointer" onClick="limpaData('txtdata_validade_fim');" src="images/botao_borracha.jpg" />
		</td>
    </tr>
    <tr>
		<td><%=GL_FTCA("Custos")%></td>
		<td><input type="radio" name="optFlag_Custo" value="F" 
		<%if trim(vntFlag_Custo)="F" or trim(vntFlag_Custo)="" then%>
			checked
		<%end if%>><%=GL_FTCA("Fixo")%></td>
		<td><input type="radio" name="optFlag_Custo" value="M" 
		<%if trim(vntFlag_Custo)="M" then%>
			checked
		<%end if%>><%=GL_FTCA("Mensal")%></td>
		<td><input type="radio" name="optFlag_Custo" value="T" 
		<%if trim(vntFlag_Custo)="T" then%>
			checked
		<%end if%>><%=GL_FTCA("Trimestral")%></td>
		
		<td><%=GL_FTCA("Moeda")%></td>
		<td colspan=3><input type="radio" name="optMoeda" value="3" 
		<%if trim(vntMoeda)="3" or trim(vntMoeda)="" then%>
			checked
		<%end if%>><%=GL_FTCA("R$")%>&nbsp;&nbsp;
		<input type="radio" name="optMoeda" value="1" 
		<%if trim(vntMoeda)="1" then%>
			checked
		<%end if%>><%=GL_FTCA("U$")%></td>
    
    </tr>
    
</table>
<br />
<table <%=GL_TITB()%> width="<%=Tamanho_Tela%>" align="center">
	<tr>
		<td align="center" <%=GL_CRTT()%>>&nbsp;<%=GL_FTTB("Tipo de Container")%></td>
		<td align="center" <%=GL_CRTT()%>>&nbsp;<%=GL_FTTB("Rota Norte(NB)<br/>Carga Seca<br/>(Dry)")%></td>
		<td align="center" <%=GL_CRTT()%>>&nbsp;<%=GL_FTTB("Rota Sul(SB)<br/>Carga Seca<br/>(Dry)")%></td>
		<td align="center" <%=GL_CRTT()%>>&nbsp;<%=GL_FTTB("Rota Norte(NB)<br/>Carga Refrigerada<br/>(Reefer)")%></td>
		<td align="center" <%=GL_CRTT()%>>&nbsp;<%=GL_FTTB("Rota Sul(SB)<br/>Carga Refrigerada<br/>(Reefer)")%></td>
	</tr>
	<tr>
	    <td align="center"><%=GL_FTCA("Container 20'")%></td>  
	    <td align="center">
            <input type="text" name="txtcusto_proposta_valorL0C0" maxlength="18" size="15" value="<%=vntarrvntcusto_proposta_valor_20pes(0)%>">
		</td>
		<td align="center">
            <input type="text" name="txtcusto_proposta_valorL0C1" maxlength="18" size="15" value="<%=vntarrvntcusto_proposta_valor_20pes(1)%>">
		</td>
		<td align="center">
            <input type="text" name="txtcusto_proposta_valorL0C2" maxlength="18" size="15" value="<%=vntarrvntcusto_proposta_valor_20pes(2)%>">
		</td>
		<td align="center">
            <input type="text" name="txtcusto_proposta_valorL0C3" maxlength="18" size="15" value="<%=vntarrvntcusto_proposta_valor_20pes(3)%>">
		</td>
	</tr>
	<tr>
	    <td align="center"><%=GL_FTCA("Container 40'")%></td>  
	    <td align="center">
            <input type="text" name="txtcusto_proposta_valorL1C0" maxlength="18" size="15" value="<%=vntarrvntcusto_proposta_valor_40pes(0)%>">
		</td>
		<td align="center">
            <input type="text" name="txtcusto_proposta_valorL1C1" maxlength="18" size="15" value="<%=vntarrvntcusto_proposta_valor_40pes(1)%>">
		</td>
		<td align="center">
            <input type="text" name="txtcusto_proposta_valorL1C2" maxlength="18" size="15" value="<%=vntarrvntcusto_proposta_valor_40pes(2)%>">
		</td>
		<td align="center">
            <input type="text" name="txtcusto_proposta_valorL1C3" maxlength="18" size="15" value="<%=vntarrvntcusto_proposta_valor_40pes(3)%>">
		</td>
	</tr>
</table>
<br>
</center>
<table width="<%=Tamanho_Tela%>" align=center>
	<tr align=center>
		<%If SESSION("flag_permissao_gravacao") = "S" Then%>
		<td width="25%" align="center">
			<%If session("flag_usuario_grafico") = "S" Then%>			
			    <input type="image" src="images/gravar.gif" align="middle" alt="Gravar" onclick="incrementa_variavel_control_form('G')" id=image1 name=image1>
			<%Else%>
			    <input type="submit" value=" Gravar " onclick="incrementa_variavel_control_form('G')" id=submit1 name=submit1>
			<%End If%>
		</td>
		<%End If%>		
		<%If SESSION("flag_permissao_exclusao") = "S" Then%>
		<td width="25%" align="center">
			<%If session("flag_usuario_grafico") = "S" Then%>			
			<input type="image" src="images/excluir.gif" align="middle" alt="Excluir" onclick="incrementa_variavel_control_form('E')" id=image2 name=image1>
			<%Else%>
			<input type="submit" value="Excluir" onclick="incrementa_variavel_control_form('E')" id=submit2 name=submit1>
			<%End If%>
		</td>
		<%End If%>		
		<td width="25%" align="center">
			<%If session("flag_usuario_grafico") = "S" Then%>
			<input type="image" src="images/Limpar.gif" align="middle" alt="Limpar" onclick="incrementa_variavel_control_form('L')" id=image6 name=image3>
			<%Else%>
			<input type="submit" value=" Limpar " onclick="incrementa_variavel_control_form('L')" id=submit6 name=submit3>
			<%End If%>
		</td>
		<td width="25%" align="center">
			<%If session("flag_usuario_grafico") = "S" Then%>
			<input type="image" src="images/Voltar.gif" align="middle" alt="Voltar" onclick="incrementa_variavel_control_form('V')" id=image4 name=image4>
			<%Else%>
			<input type="submit" value=" Voltar " onclick="incrementa_variavel_control_form('V')" id=submit4 name=submit4>
			<%End If%>
		</td>
	</tr>
</table>


</form>		
<script type="text/javascript" src="FormataDataHora.js"></script>
<script type="text/javascript" language="javascript">

addData('txtdata_validade_ini');
addData('txtdata_validade_fim');

if (typeof(ValidatorOnLoad) == 'function') {
    ValidatorOnLoad();
}

function Focus(){

    document.frmCadastro.txtdata_validade_ini.focus();

}

</script>

</body>
</html>
<%Limpa_Session()%>

