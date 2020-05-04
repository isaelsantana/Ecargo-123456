Set Ansi_Nulls ON
Set Quoted_Identifier ON
go
If Object_Id('SP_050_GRA_HIST_CUSTO_BAF01', 'P') Is Null
	Exec ('Create Proc SP_050_GRA_HIST_CUSTO_BAF01 As Return 0;')
go
 
 
 
 
/* 
EXEC SP_050_GRA_CUSTO_BAF01 '2010/11/12', '2010/11/12', 'F', 3, 1
*/

Alter ProcEDURE SP_050_GRA_HIST_CUSTO_BAF01   /* SP_050_GRA_CUSTO_BAF01.sql*/

		@CUSTO_PROPOSTA_ID INT , 
		@data_ini			VARCHAR(10),
		@data_fim			VARCHAR(10), 
		@FLAG_CUSTO			CHAR(1),
		@MOEDA				INT,
		@VAL_CARGA_20_DRY_N numeric(15,2) ,
		@VAL_CARGA_20_DRY_S numeric(15,2) ,
		@VAL_CARGA_20_REEFER_N numeric(15,2) ,
		@VAL_CARGA_20_REEFER_S numeric(15,2) ,
		@VAL_CARGA_40_DRY_N numeric(15,2) ,
		@VAL_CARGA_40_DRY_S numeric(15,2) ,
		@VAL_CARGA_40_REEFER_N numeric(15,2) ,
		@VAL_CARGA_40_REEFER_S numeric(15,2) ,
		@Usuario_ID 		INT

AS


DECLARE	@retorno	INT,
		@id			INT
		
		INSERT INTO HISTORICO_CUSTO_PROPOSTA
			(
				CUSTO_PROPOSTA_ID
				,TAB_TIPO_CUSTO_PROPOSTA_ID
				,MOEDA_ID
				,DATA_VALIDADE_INI
				,DATA_VALIDADE_FIM
				,TAB_STATUS_ID
				,TIPO_CUSTO
				,DATA_INCLUSAO
				,USUARIO_ID
				,VAL_CARGA_20_DRY_S
				,VAL_CARGA_20_DRY_N
				,VAL_CARGA_40_DRY_S
				,VAL_CARGA_40_DRY_N
				,VAL_CARGA_20_REEFER_S
				,VAL_CARGA_20_REEFER_N
				,VAL_CARGA_40_REEFER_S
				,VAL_CARGA_40_REEFER_N
			)
		VALUES
			(@CUSTO_PROPOSTA_ID,
			10,
			@MOEDA,
			CONVERT(DATETIME,@data_ini),
			CONVERT(DATETIME,@data_fim),			
			1,
			@FLAG_CUSTO,
			GETDATE(),
			@Usuario_ID 
			,@VAL_CARGA_20_DRY_S
			,@VAL_CARGA_20_DRY_N
			,@VAL_CARGA_40_DRY_S
			,@VAL_CARGA_40_DRY_N
			,@VAL_CARGA_20_REEFER_S
			,@VAL_CARGA_20_REEFER_N
			,@VAL_CARGA_40_REEFER_S
			,@VAL_CARGA_40_REEFER_N
			)

		IF @@ROWCOUNT = 0
		BEGIN
				SELECT 10 retorno, 'Problemas na Inclusão. Nenhum registro afetado.' msg_ret
			RETURN 
		END
		IF @@ERROR <> 0
		BEGIN
			SELECT error retorno, description msg_ret 
			FROM master.dbo.sysmessages 
			WHERE error = @@ERROR 
			RETURN 
		END

		SELECT @id = Scope_Identity()
		/* GRAVANDO A LOG NO SISTEMA: TABELA_SISTEMA_ID, USUARIO_ID, REGISTRO_ID, TAB_TIPO_ACAO_ID */
		/* RECEBE RETORNO PARA TER CERTEZA QUE GRAVOU */
		/* TABELA ACESSADA: CUSTO_PROPOSTA, seu ID eh 1028 */
		EXEC SP_SIG_INC_LOG_SISTEMA2 100361 , @usuario_id, @id, 1, @retorno OUTPUT 
		IF @retorno <> 0
		BEGIN
			SELECT @retorno retorno, 'Problemas na gravação do registro de LOG.' msg_ret 
		RETURN 
		END

		INSERT INTEGRACAO_BAF (
			TAB_STATUS_ID , 
			TAB_STATUS_INTEGRACAO_ID, 
			CUSTO_PROPOSTA_ID , 
			HISTORICO_CUSTO_PROPOSTA_ID,
			DATA_INCL			
		) 
		SELECT 
			1, 
			501,
			@CUSTO_PROPOSTA_ID, 
			@id, 
			GETDATE()

		SELECT @id AS HISTORICO_CUSTO_PROPOSTA_ID , 0 retorno, '' msg_ret
	
 
 
go
Grant Execute On dbo.SP_050_GRA_HIST_CUSTO_BAF01 To Sistema
go
