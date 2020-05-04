If Not Exists (Select 1 From [Funcao] Where Funcao_Id = 12446)    
	begin 
		Insert [Funcao]( [Funcao_Id], [Desc_Funcao], [Tab_Status_Id], [Tab_Tipo_Funcao_Id], [Desc_Funcao_Resum], [Nome_Elemento], [Nome_Figura], [Flag_Ctr_Acesso], [Ordem_Funcao], [Nome_Asp], [Nome_Figura_Sombra], [Order_Funcao], [Titulo_Principal], [Nome_Figura_Menu], [Nome_Batch], [Flag_Abre_Janela], [Nome_Arquivo], [Diretorio_Arquivo], [Funcao_Pai_Id], [Versao], [Flag_Mobile], [Tema_Id], [Nome_Diretorio], [Url], [Flag_Multilinguagem], [Nome_Arquivo_Help])     
		Select [Funcao_Id]=12446,[Desc_Funcao]='Cadastro de Custos de BAF',[Tab_Status_Id]=1,[Tab_Tipo_Funcao_Id]=26,[Desc_Funcao_Resum]='Custo de BAF',[Nome_Elemento]=Null,[Nome_Figura]=Null,[Flag_Ctr_Acesso]=Null,[Ordem_Funcao]=64,[Nome_Asp]='CustoBAFCad050.asp',[Nome_Figura_Sombra]=Null,[Order_Funcao]=Null,[Titulo_Principal]=Null,[Nome_Figura_Menu]=Null,[Nome_Batch]=Null,[Flag_Abre_Janela]=Null,[Nome_Arquivo]=Null,[Diretorio_Arquivo]=Null,[Funcao_Pai_Id]=Null,[Versao]=6.00,[Flag_Mobile]=Null,[Tema_Id]=Null,[Nome_Diretorio]=Null,[Url]=Null,[Flag_Multilinguagem]=Null,[Nome_Arquivo_Help]=Null  
	end 
else 
	begin 
		update funcao  set versao = 7 where funcao_id = 12446
	end 

If Not Exists (Select 1 From [Tabela_Sistema] Where Tabela_Sistema_Id = 100361)    
	begin 
		Insert [Tabela_Sistema]( [Tabela_Sistema_Id], [Nome_Tabela], [Sysobjects_Id], [Flag_Trigger_Ativada])     
		Select [Tabela_Sistema_Id]=100361,[Nome_Tabela]='HISTORICO_CUSTO_PROPOSTA',[Sysobjects_Id]=Null,[Flag_Trigger_Ativada]='N' 
	end 

If Not Exists (Select 1 From [Tab_Parametro_Sistema] Where Tab_Parametro_Sistema_Id = 15078)    
	begin 
		Insert [Tab_Parametro_Sistema]( [Tab_Parametro_Sistema_Id], [Desc_Parametro_Sistema], [Parametro], [Funcao_Id], [Msg_Parametro], [Default_Parametro], [Desc_Parametro], [Desc_Parametro_Adic], [Ts], [Tab_Status_Bloqueio_Id], [Flag_Exibe_Tela], [Doc], [Campo_Consistencia_Id])     
		Select [Tab_Parametro_Sistema_Id]=15078,[Desc_Parametro_Sistema]='Habilitado grava historico baf e integracao baf',[Parametro]='N',[Funcao_Id]=12446,[Msg_Parametro]=Null,[Default_Parametro]='N',[Desc_Parametro]='Habilitado grava historico baf e integracao baf',[Desc_Parametro_Adic]=Null,[Ts]=Null,[Tab_Status_Bloqueio_Id]=Null,[Flag_Exibe_Tela]=Null,[Doc]=Null,[Campo_Consistencia_Id]=Null  
	end 

if exists (select top 1 1 from empresa where nome_fantasia like '%MERCOSUL%') 
	begin 
		 Update TAB_PARAMETRO_SISTEMA  Set PARAMETRO = 'S'  Where TAB_PARAMETRO_SISTEMA_ID = 15078	

		 -- Agendamento BATCH SQL 		 
		 BEGIN TRANSACTION
			DECLARE @ReturnCode INT
			DECLARE @banco varchar(255) 

			set @banco =DB_NAME()
			SELECT @ReturnCode = 0		
			IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
			BEGIN
			EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
			IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

			END

			DECLARE @jobId BINARY(16)
			EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Integracao BAF - 050', 
					@enabled=1, 
					@notify_level_eventlog=0, 
					@notify_level_email=0, 
					@notify_level_netsend=0, 
					@notify_level_page=0, 
					@delete_level=0, 
					@description=N'No description available.', 
					@category_name=N'[Uncategorized (Local)]', 
					@owner_login_name=N'SISTEMA', @job_id = @jobId OUTPUT
			IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
			/****** Object:  Step [SP_050_BATCH_INTEGRACAO_BAF01]    Script Date: 26/03/2020 14:33:47 ******/
			EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'SP_050_BATCH_INTEGRACAO_BAF01', 
					@step_id=1, 
					@cmdexec_success_code=0, 
					@on_success_action=1, 
					@on_success_step_id=0, 
					@on_fail_action=2, 
					@on_fail_step_id=0, 
					@retry_attempts=0, 
					@retry_interval=0, 
					@os_run_priority=0, @subsystem=N'TSQL', 
					@command=N'Exec SP_050_BATCH_INTEGRACAO_BAF01', 
					@database_name=@banco, 
					@flags=0
			IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
			EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
			IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
			EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Job Diario', 
					@enabled=1, 
					@freq_type=4, 
					@freq_interval=1, 
					@freq_subday_type=1, 
					@freq_subday_interval=0, 
					@freq_relative_interval=0, 
					@freq_recurrence_factor=0, 
					@active_start_date=20200326, 
					@active_end_date=99991231, 
					@active_start_time=0, 
					@active_end_time=235959, 
					@schedule_uid=N'dc2a3d4f-79b8-41e8-98b8-c31ffc38a110'
			IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
			EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
			IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
			COMMIT TRANSACTION
			GOTO EndSave
			QuitWithRollback:
				IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
			EndSave:

	end 