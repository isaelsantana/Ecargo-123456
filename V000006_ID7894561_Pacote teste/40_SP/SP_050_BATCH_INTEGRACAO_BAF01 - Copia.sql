
go
If Object_Id('SP_050_BATCH_INTEGRACAO_BAF01', 'P') Is Null
	Exec ('Create Proc SP_050_BATCH_INTEGRACAO_BAF01 As Return 0;')
go
Alter ProcEDURE SP_050_BATCH_INTEGRACAO_BAF01
(
	@FLAG_PRINT CHAR(1) = 'N'
)
AS 

Declare @Cont                Int = 1, 
		@Qtd_Temp_Integracao Int, 
		@Qtd_Temp_Baf        Int, 
		@Cont_Baf            Int = 1

Declare @Integracao_Baf_Id     Int, 
		@Moeda_Id              Int, 
		@Custo_Proposta_Id     Int, 
		@Tipo_Custo            Char(1), 
		@Usuario_Id            Int, 
		@Val_Carga_20_Dry_S    Numeric(15, 2), 
		@Val_Carga_20_Dry_N    Numeric(15, 2), 
		@Val_Carga_20_Reefer_S Numeric(15, 2), 
		@Val_Carga_20_Reefer_N Numeric(15, 2), 
		@Val_Carga_40_Dry_S    Numeric(15, 2), 
		@Val_Carga_40_Dry_N    Numeric(15, 2), 
		@Val_Carga_40_Reefer_S Numeric(15, 2), 
		@Val_Carga_40_Reefer_N Numeric(15, 2)

Declare @Valor_Baf                      Numeric(15, 2), 
		@Sentido                        Char(1), 
		@Flag_Reefer                    Char(1), 
		@Tipo_Equipamento               Int, 
		@Tabela_Preco_Cliente_Id        Int, 
		@Tabela_Proposta_Destino_Id     Int, 
		@Val_Baf_Antigo                 Numeric(15, 2), 
		@Val_Baf_Novo                   Numeric(15, 2), 
		@Tabela_Proposta_Atributo_Ident Int

Create Table #Temp_Integracao_Baf
(	Id                    Int Identity Primary Key Clustered , 
	Integracao_Baf_Id     Int Null, 
	Moeda_Id              Int Null, 
	Custo_Proposta_Id     Int Null, 
	Tipo_Custo            Char(1) Null, 
	Usuario_Id            Int Null, 
	Val_Carga_20_Dry_S    Numeric(15, 2) Null, 
	Val_Carga_20_Dry_N    Numeric(15, 2) Null, 
	Val_Carga_20_Reefer_S Numeric(15, 2) Null, 
	Val_Carga_20_Reefer_N Numeric(15, 2) Null, 
	Val_Carga_40_Dry_S    Numeric(15, 2) Null, 
	Val_Carga_40_Dry_N    Numeric(15, 2) Null, 
	Val_Carga_40_Reefer_S Numeric(15, 2) Null, 
	Val_Carga_40_Reefer_N Numeric(15, 2) Null
)

Create Table #Temp_Valor_Baf
(	Id               Int Identity Primary Key Clustered , 
	Tipo_Equipamento Int, 
	Sentido          Char(1), 
	Valor_Baf        Numeric(15, 2), 
	Flag_Reefer      Char(1),
	Custo_Proposta_Id Int 
)

Create Table #Temp_Prop_Baf
(	Id                             Int Identity Primary Key Clustered , 
	Tabela_Preco_Cliente_Id        Int,
	Tabela_Proposta_Destino_Id     Int, 
	Tabela_Proposta_Atributo_Ident Int, 
	Val_Baf_Antigo                 Numeric(15, 2), 
	Val_Baf_Novo                   Numeric(15, 2),
	Index Idx_TPD_TPAI (Tabela_Proposta_Destino_Id, Tabela_Proposta_Atributo_Ident)
)

Insert Into #Temp_Integracao_Baf
(	Integracao_Baf_Id, 
	Moeda_Id, 
	Custo_Proposta_Id, 
	Tipo_Custo, 
	Usuario_Id, 
	Val_Carga_20_Dry_S, 
	Val_Carga_20_Dry_N, 
	Val_Carga_20_Reefer_S, 
	Val_Carga_20_Reefer_N, 
	Val_Carga_40_Dry_S, 
	Val_Carga_40_Dry_N, 
	Val_Carga_40_Reefer_S, 
	Val_Carga_40_Reefer_N
)
Select
		Ib.Integracao_Baf_Id As      Integracaobafid, 
		Hcp.Moeda_Id As              Moedaid, 
		Ib.Custo_Proposta_Id As      Custopropostaid, 
		Hcp.Tipo_Custo As            Tipocusto, 
		Hcp.Usuario_Id As            Usuarioid, 
		Hcp.Val_Carga_20_Dry_S As    ValCarga20Drys, 
		Hcp.Val_Carga_20_Dry_N As    ValCarga20Dryn, 
		Hcp.Val_Carga_20_Reefer_S As ValCarga20Reefers, 
		Hcp.Val_Carga_20_Reefer_N As ValCarga20Reefern, 
		Hcp.Val_Carga_40_Dry_S As    ValCarga40Drys, 
		Hcp.Val_Carga_40_Dry_N As    ValCarga40Dryn, 
		Hcp.Val_Carga_40_Reefer_S As ValCarga40Reefers, 
		Hcp.Val_Carga_40_Reefer_N As ValCarga40Reefern
From 
		Integracao_Baf Ib
		Inner Join Historico_Custo_Proposta Hcp On Hcp.Historico_Custo_Proposta_Id = Ib.Historico_Custo_Proposta_Id
			And Hcp.Tab_Status_Id = 1
Where
		Ib.Tab_Status_Id = 1
And		Ib.Tab_Status_Integracao_Id = 501


Set @Qtd_Temp_Integracao = @@Rowcount

Select [@Qtd_Temp_Integracao] = @Qtd_Temp_Integracao

While @Cont <= @Qtd_Temp_Integracao
	Begin

		truncate table #Temp_Valor_Baf
		truncate table #Temp_Prop_Baf
		Select
				@Integracao_Baf_Id = Integracao_Baf_Id, 
				@Moeda_Id = Moeda_Id, 
				@Custo_Proposta_Id = Custo_Proposta_Id, 
				@Tipo_Custo = Tipo_Custo, 
				@Usuario_Id = Usuario_Id, 
				@Val_Carga_20_Dry_S = Val_Carga_20_Dry_S, 
				@Val_Carga_20_Dry_N = Val_Carga_20_Dry_N, 
				@Val_Carga_20_Reefer_S = Val_Carga_20_Reefer_S, 
				@Val_Carga_20_Reefer_N = Val_Carga_20_Reefer_N, 
				@Val_Carga_40_Dry_S = Val_Carga_40_Dry_S, 
				@Val_Carga_40_Dry_N = Val_Carga_40_Dry_N, 
				@Val_Carga_40_Reefer_S = Val_Carga_40_Reefer_S, 
				@Val_Carga_40_Reefer_N = Val_Carga_40_Reefer_N
		From
				#Temp_Integracao_Baf
		Where
				Id = @Cont

		Update Integracao_Baf
		Set    
			Tab_Status_Integracao_Id = 1079
		Where  Integracao_Baf_Id = @Integracao_Baf_Id

		Insert Into #Temp_Valor_Baf
		(	
			Custo_Proposta_Id,
			Valor_Baf, 
			Tipo_Equipamento, 
			Sentido, 
			Flag_Reefer
		)
		Values
			(@Custo_Proposta_Id , isnull(@Val_Carga_20_Dry_S,0), 20, 'S', 'N'),
			(@Custo_Proposta_Id , isnull(@Val_Carga_20_Dry_N,0), 20, 'N', 'N'),
			(@Custo_Proposta_Id , isnull(@Val_Carga_20_Reefer_S,0), 20, 'S', 'S'),
			(@Custo_Proposta_Id , isnull(@Val_Carga_20_Reefer_N,0), 20, 'N', 'S'),
			(@Custo_Proposta_Id , isnull(@Val_Carga_40_Dry_S,0), 40, 'S', 'N'),
			(@Custo_Proposta_Id , isnull(@Val_Carga_40_Dry_N,0), 40, 'N', 'N'),
			(@Custo_Proposta_Id , isnull(@Val_Carga_40_Reefer_S,0), 40, 'S', 'S'),
			(@Custo_Proposta_Id , isnull(@Val_Carga_40_Reefer_N,0), 40, 'N', 'S')

		update 
			Tpa
		set 
			Tpa.Val_Atributo  = Custo.Valor
		output			
			Ult_Tpc.Tabela_Preco_Cliente_Id , 
			Tpd.Tabela_Proposta_Destino_Id  , 
			inserted.Tabela_Proposta_Atributo_Ident,				
			deleted.Val_Atributo ,
			inserted.Val_Atributo						  
		Into #Temp_Prop_Baf (Tabela_Preco_Cliente_Id ,Tabela_Proposta_Destino_Id , Tabela_Proposta_Atributo_Ident ,  Val_Baf_Antigo , Val_Baf_Novo)	
		From          Tabela_Preco_Cliente Tpc
						Inner Join Tabela_Proposta_Destino Tpd On Tpd.Tabela_Preco_Cliente_Id = Tpc.Tabela_Preco_Cliente_Id
																And Tpd.Tab_Status_Id = 1
						Inner Join Tabela_Proposta_Atributo Tpa On Tpa.Tabela_Proposta_Destino_Id = Tpd.Tabela_Proposta_Destino_Id
																	And Tpa.Tab_Status_Id = 1
																	And Tpa.Tab_Atributo_Proposta_Id = 876
			Cross Apply
			(
				Select Top 1 Tabela_Preco_Cliente_Id
				From Tabela_Preco_Cliente
				Where Id_Sistema_Externo = Tpc.Id_Sistema_Externo
						And Tab_Status_Id = 1
				Order By Tabela_Preco_Cliente_Id Desc
			) Ult_Tpc
			Cross Apply
			(
				Select Desc_Container = IsNull(Desc_Container_Resum, ''), 
						Flag_Reefer = IsNull(Indic_Reefer, 'N'), 
						Num_Teus = IsNull(Num_Pes, 0)
				From Tab_Tipo_Container
				Where Tab_Status_Id = 1
						And Tab_Tipo_Container_Id = Tpd.Tab_Tipo_Container_Id
			) As Ttt
			Cross Apply
			(
				Select Sentido = Substring(Pc.Cod_Profit_Centre, 4, 1)
				From Profit_Centre Pc
				Where Pc.Tab_Status_Id = 1
						And Pc.Porto_Origem_Id = Tpd.Porto_Origem_Id
						And Pc.Porto_Destino_Id = Tpd.Porto_Id
			) Pc
			Cross Apply
			(
				Select Cp.Tipo_Custo, 
						Cp.Custo_Proposta_Id, 
						Cpv.Valor_Baf As Valor, 
						Cpv.Flag_Reefer, 
						Cpv.Tipo_Equipamento, 
						Cpv.Sentido
				From Custo_Proposta Cp
						Inner Join #Temp_Valor_Baf Cpv On Cpv.Custo_Proposta_Id = Cp.Custo_Proposta_Id					
				Where Cp.Tab_Status_Id = 1
						And Cp.Tab_Tipo_Custo_Proposta_Id = 10
						And Getdate() Between Cp.Data_Validade_Ini And Cp.Data_Validade_Fim
			) Custo
		Where Tpc.Tab_Status_Id = 1
				And Ult_Tpc.Tabela_Preco_Cliente_Id = Tpc.Tabela_Preco_Cliente_Id
				And Tpc.Tipo_Custo = Custo.Tipo_Custo
				And Pc.Sentido = Custo.Sentido
				And Ttt.Num_Teus = Custo.Tipo_Equipamento
				And Ttt.Flag_Reefer = Custo.Flag_Reefer
				And Custo.Valor <> Tpa.Val_Atributo
				And Tpc.Tipo_Proposta_Id = 93

		if exists(select top 1 1 from #Temp_Prop_Baf) 
			begin 
				Insert Hist_Baf_Proposta_Destino
				(	Valor_Antigo, 
					Valor_Novo, 
					Tabela_Preco_Cliente_Id, 
					Tabela_Proposta_Destino_Id, 
					Data_Incl, 
					Usuario_Id, 
					Tab_Status_Id, 
					Observacao, 
					Integracao_Baf_Id,
					Funcao_id 
				)
				Select	Val_Baf_Antigo, Val_Baf_Novo, Tabela_Preco_Cliente_Id, Tabela_Proposta_Destino_Id, Getdate(), 1, @Usuario_Id, Object_Id(''), @Integracao_Baf_Id,12446 
				From	#Temp_Prop_Baf
			end

		Update Integracao_Baf
		Set    
			Tab_Status_Integracao_Id = 1079
		Where  Integracao_Baf_Id = 1

		Set @Cont+=1
	End

If Object_Id ('tempdb..#Temp_Integracao_Baf ') Is Not Null
	Drop Table #Temp_Integracao_Baf 
If Object_Id ('tempdb..#Temp_Valor_Baf ') Is Not Null
	Drop Table #Temp_Valor_Baf
If Object_Id ('tempdb..#Temp_Prop_Baf ') Is Not Null
	Drop Table #Temp_Prop_Baf
go
Grant Execute On dbo.SP_050_BATCH_INTEGRACAO_BAF01 To Sistema
go
