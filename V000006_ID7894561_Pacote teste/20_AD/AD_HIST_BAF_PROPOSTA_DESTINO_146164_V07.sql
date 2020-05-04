If Object_Id('HIST_BAF_PROPOSTA_DESTINO') Is Null
	Create Table [HIST_BAF_PROPOSTA_DESTINO] ([HIST_BAF_PROPOSTA_DESTINO_ID] int Not Null Identity(1,1))
Go
 
	Alter Table [HIST_BAF_PROPOSTA_DESTINO] Alter Column [HIST_BAF_PROPOSTA_DESTINO_ID] int Not Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'VALOR_ANTIGO' And [object_Id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO'))
	Alter Table [HIST_BAF_PROPOSTA_DESTINO] Add [VALOR_ANTIGO] numeric(15,2) Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO') And c.Name = 'VALOR_ANTIGO' And Type_Name(c.system_type_id) = 'numeric' And c.max_length = 9 And c.[precision] = 15 And c.scale = 2 /*And c.is_nullable = 1*/)
		Alter Table [HIST_BAF_PROPOSTA_DESTINO] Alter Column [VALOR_ANTIGO] numeric(15,2) Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'VALOR_NOVO' And [object_Id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO'))
	Alter Table [HIST_BAF_PROPOSTA_DESTINO] Add [VALOR_NOVO] numeric(15,2) Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO') And c.Name = 'VALOR_NOVO' And Type_Name(c.system_type_id) = 'numeric' And c.max_length = 9 And c.[precision] = 15 And c.scale = 2 /*And c.is_nullable = 1*/)
		Alter Table [HIST_BAF_PROPOSTA_DESTINO] Alter Column [VALOR_NOVO] numeric(15,2) Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'TABELA_PRECO_CLIENTE_ID' And [object_Id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO'))
	Alter Table [HIST_BAF_PROPOSTA_DESTINO] Add [TABELA_PRECO_CLIENTE_ID] int Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO') And c.Name = 'TABELA_PRECO_CLIENTE_ID' And Type_Name(c.system_type_id) = 'int' And c.max_length = 4 And c.[precision] = 10 And c.scale = 0 /*And c.is_nullable = 1*/)
		Alter Table [HIST_BAF_PROPOSTA_DESTINO] Alter Column [TABELA_PRECO_CLIENTE_ID] int Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'TABELA_PROPOSTA_DESTINO_ID' And [object_Id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO'))
	Alter Table [HIST_BAF_PROPOSTA_DESTINO] Add [TABELA_PROPOSTA_DESTINO_ID] int Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO') And c.Name = 'TABELA_PROPOSTA_DESTINO_ID' And Type_Name(c.system_type_id) = 'int' And c.max_length = 4 And c.[precision] = 10 And c.scale = 0 /*And c.is_nullable = 1*/)
		Alter Table [HIST_BAF_PROPOSTA_DESTINO] Alter Column [TABELA_PROPOSTA_DESTINO_ID] int Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'DATA_INCL' And [object_Id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO'))
	Alter Table [HIST_BAF_PROPOSTA_DESTINO] Add [DATA_INCL] datetime Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO') And c.Name = 'DATA_INCL' And Type_Name(c.system_type_id) = 'datetime' And c.max_length = 8 And c.[precision] = 23 And c.scale = 3 /*And c.is_nullable = 1*/)
		Alter Table [HIST_BAF_PROPOSTA_DESTINO] Alter Column [DATA_INCL] datetime Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'USUARIO_ID' And [object_Id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO'))
	Alter Table [HIST_BAF_PROPOSTA_DESTINO] Add [USUARIO_ID] int Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO') And c.Name = 'USUARIO_ID' And Type_Name(c.system_type_id) = 'int' And c.max_length = 4 And c.[precision] = 10 And c.scale = 0 /*And c.is_nullable = 1*/)
		Alter Table [HIST_BAF_PROPOSTA_DESTINO] Alter Column [USUARIO_ID] int Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'TAB_STATUS_ID' And [object_Id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO'))
	Alter Table [HIST_BAF_PROPOSTA_DESTINO] Add [TAB_STATUS_ID] int Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO') And c.Name = 'TAB_STATUS_ID' And Type_Name(c.system_type_id) = 'int' And c.max_length = 4 And c.[precision] = 10 And c.scale = 0 /*And c.is_nullable = 1*/)
		Alter Table [HIST_BAF_PROPOSTA_DESTINO] Alter Column [TAB_STATUS_ID] int Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'OBSERVACAO' And [object_Id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO'))
	Alter Table [HIST_BAF_PROPOSTA_DESTINO] Add [OBSERVACAO] varchar(2000) Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO') And c.Name = 'OBSERVACAO' And Type_Name(c.system_type_id) = 'varchar' And c.max_length = 2000 And c.[precision] = 0 And c.scale = 0 /*And c.is_nullable = 1*/)
		Alter Table [HIST_BAF_PROPOSTA_DESTINO] Alter Column [OBSERVACAO] varchar(2000) Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'INTEGRACAO_BAF_ID' And [object_Id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO'))
	Alter Table [HIST_BAF_PROPOSTA_DESTINO] Add [INTEGRACAO_BAF_ID] int Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO') And c.Name = 'INTEGRACAO_BAF_ID' And Type_Name(c.system_type_id) = 'int' And c.max_length = 4 And c.[precision] = 10 And c.scale = 0 /*And c.is_nullable = 1*/)
		Alter Table [HIST_BAF_PROPOSTA_DESTINO] Alter Column [INTEGRACAO_BAF_ID] int Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'FUNCAO_ID' And [object_Id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO'))
	Alter Table [HIST_BAF_PROPOSTA_DESTINO] Add [FUNCAO_ID] int Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HIST_BAF_PROPOSTA_DESTINO') And c.Name = 'FUNCAO_ID' And Type_Name(c.system_type_id) = 'int' And c.max_length = 4 And c.[precision] = 10 And c.scale = 0 /*And c.is_nullable = 1*/)
		Alter Table [HIST_BAF_PROPOSTA_DESTINO] Alter Column [FUNCAO_ID] int Null
Go
If Not Exists(Select 1 From sys.key_constraints kc Where parent_object_id = Object_Id('HIST_BAF_PROPOSTA_DESTINO') And kc.[type] = 'PK')
	Alter Table HIST_BAF_PROPOSTA_DESTINO Add Constraint PK__HIST_BAF__E9E458E0C017090A Primary Key (HIST_BAF_PROPOSTA_DESTINO_ID)
Go
/******************************************************/
/******************** Foreign Keys ********************/
/******************************************************/

If Not Exists(Select 1 From sys.foreign_keys fk Where fk.parent_object_id = Object_Id('HIST_BAF_PROPOSTA_DESTINO') And fk.name = 'FK__HIST_BAF___TABEL__63C35819')
	Alter Table [HIST_BAF_PROPOSTA_DESTINO] Add Constraint [FK__HIST_BAF___TABEL__63C35819] Foreign Key (TABELA_PRECO_CLIENTE_ID) References Tabela_Preco_Cliente (Tabela_Preco_Cliente_Id)
Go
If Not Exists(Select 1 From sys.foreign_keys fk Where fk.parent_object_id = Object_Id('HIST_BAF_PROPOSTA_DESTINO') And fk.name = 'FK__HIST_BAF___TABEL__64B77C52')
	Alter Table [HIST_BAF_PROPOSTA_DESTINO] Add Constraint [FK__HIST_BAF___TABEL__64B77C52] Foreign Key (TABELA_PROPOSTA_DESTINO_ID) References Tabela_Proposta_Destino (Tabela_Proposta_Destino_Id)
Go
If Not Exists(Select 1 From sys.foreign_keys fk Where fk.parent_object_id = Object_Id('HIST_BAF_PROPOSTA_DESTINO') And fk.name = 'FK__HIST_BAF___USUAR__65ABA08B')
	Alter Table [HIST_BAF_PROPOSTA_DESTINO] Add Constraint [FK__HIST_BAF___USUAR__65ABA08B] Foreign Key (USUARIO_ID) References Usuario (Usuario_Id)
Go
If Not Exists(Select 1 From sys.foreign_keys fk Where fk.parent_object_id = Object_Id('HIST_BAF_PROPOSTA_DESTINO') And fk.name = 'FK__HIST_BAF___TAB_S__669FC4C4')
	Alter Table [HIST_BAF_PROPOSTA_DESTINO] Add Constraint [FK__HIST_BAF___TAB_S__669FC4C4] Foreign Key (TAB_STATUS_ID) References Tab_Status (Tab_Status_Id)
Go
If Not Exists(Select 1 From sys.foreign_keys fk Where fk.parent_object_id = Object_Id('HIST_BAF_PROPOSTA_DESTINO') And fk.name = 'FK__HIST_BAF___INTEG__6793E8FD')
	Alter Table [HIST_BAF_PROPOSTA_DESTINO] Add Constraint [FK__HIST_BAF___INTEG__6793E8FD] Foreign Key (INTEGRACAO_BAF_ID) References INTEGRACAO_BAF (INTEGRACAO_BAF_ID)
Go
If Not Exists(Select 1 From sys.foreign_keys fk Where fk.parent_object_id = Object_Id('HIST_BAF_PROPOSTA_DESTINO') And fk.name = 'FK__HIST_BAF___FUNCA__033C0372')
	Alter Table [HIST_BAF_PROPOSTA_DESTINO] Add Constraint [FK__HIST_BAF___FUNCA__033C0372] Foreign Key (FUNCAO_ID) References FUNCAO (FUNCAO_ID)
Go
/*************** Check Constraints ****************/
/*************** Defaults ****************/
