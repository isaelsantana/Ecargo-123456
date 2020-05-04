/************************************************************************/
/************** Script de criação e modificação de colunas **************/
/**************             18/03/2020 15:44:21            **************/
/************************************************************************/

If Object_Id('INTEGRACAO_BAF') Is Null
	Create Table [INTEGRACAO_BAF] ([INTEGRACAO_BAF_ID] int Not Null Identity(1,1))
Go
 
	Alter Table [INTEGRACAO_BAF] Alter Column [INTEGRACAO_BAF_ID] int Not Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'TAB_STATUS_ID' And [object_Id] = Object_Id('INTEGRACAO_BAF'))
	Alter Table [INTEGRACAO_BAF] Add [TAB_STATUS_ID] int Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('INTEGRACAO_BAF') And c.Name = 'TAB_STATUS_ID' And Type_Name(c.system_type_id) = 'int' And c.max_length = 4 And c.[precision] = 10 And c.scale = 0 /*And c.is_nullable = 1*/)
		Alter Table [INTEGRACAO_BAF] Alter Column [TAB_STATUS_ID] int Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'TAB_STATUS_INTEGRACAO_ID' And [object_Id] = Object_Id('INTEGRACAO_BAF'))
	Alter Table [INTEGRACAO_BAF] Add [TAB_STATUS_INTEGRACAO_ID] int Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('INTEGRACAO_BAF') And c.Name = 'TAB_STATUS_INTEGRACAO_ID' And Type_Name(c.system_type_id) = 'int' And c.max_length = 4 And c.[precision] = 10 And c.scale = 0 /*And c.is_nullable = 1*/)
		Alter Table [INTEGRACAO_BAF] Alter Column [TAB_STATUS_INTEGRACAO_ID] int Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'CUSTO_PROPOSTA_ID' And [object_Id] = Object_Id('INTEGRACAO_BAF'))
	Alter Table [INTEGRACAO_BAF] Add [CUSTO_PROPOSTA_ID] int Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('INTEGRACAO_BAF') And c.Name = 'CUSTO_PROPOSTA_ID' And Type_Name(c.system_type_id) = 'int' And c.max_length = 4 And c.[precision] = 10 And c.scale = 0 /*And c.is_nullable = 1*/)
		Alter Table [INTEGRACAO_BAF] Alter Column [CUSTO_PROPOSTA_ID] int Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'HISTORICO_CUSTO_PROPOSTA_ID' And [object_Id] = Object_Id('INTEGRACAO_BAF'))
	Alter Table [INTEGRACAO_BAF] Add [HISTORICO_CUSTO_PROPOSTA_ID] int Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('INTEGRACAO_BAF') And c.Name = 'HISTORICO_CUSTO_PROPOSTA_ID' And Type_Name(c.system_type_id) = 'int' And c.max_length = 4 And c.[precision] = 10 And c.scale = 0 /*And c.is_nullable = 1*/)
		Alter Table [INTEGRACAO_BAF] Alter Column [HISTORICO_CUSTO_PROPOSTA_ID] int Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'DATA_INCL' And [object_Id] = Object_Id('INTEGRACAO_BAF'))
	Alter Table [INTEGRACAO_BAF] Add [DATA_INCL] datetime Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('INTEGRACAO_BAF') And c.Name = 'DATA_INCL' And Type_Name(c.system_type_id) = 'datetime' And c.max_length = 8 And c.[precision] = 23 And c.scale = 3 /*And c.is_nullable = 1*/)
		Alter Table [INTEGRACAO_BAF] Alter Column [DATA_INCL] datetime Null
Go
If Not Exists(Select 1 From sys.key_constraints kc Where parent_object_id = Object_Id('INTEGRACAO_BAF') And kc.[type] = 'PK')
	Alter Table INTEGRACAO_BAF Add Constraint PK__INTEGRAC__6C566935992A8D3C Primary Key (INTEGRACAO_BAF_ID)
Go
/******************************************************/
/******************** Foreign Keys ********************/
/******************************************************/

If Not Exists(Select 1 From sys.foreign_keys fk Where fk.parent_object_id = Object_Id('INTEGRACAO_BAF') And fk.name = 'FK__INTEGRACA__TAB_S__5E0A7EC3')
	Alter Table [INTEGRACAO_BAF] Add Constraint [FK__INTEGRACA__TAB_S__5E0A7EC3] Foreign Key (TAB_STATUS_ID) References Tab_Status (Tab_Status_Id)
Go
If Not Exists(Select 1 From sys.foreign_keys fk Where fk.parent_object_id = Object_Id('INTEGRACAO_BAF') And fk.name = 'FK__INTEGRACA__TAB_S__5EFEA2FC')
	Alter Table [INTEGRACAO_BAF] Add Constraint [FK__INTEGRACA__TAB_S__5EFEA2FC] Foreign Key (TAB_STATUS_INTEGRACAO_ID) References Tab_Status (Tab_Status_Id)
Go
If Not Exists(Select 1 From sys.foreign_keys fk Where fk.parent_object_id = Object_Id('INTEGRACAO_BAF') And fk.name = 'FK__INTEGRACA__CUSTO__5FF2C735')
	Alter Table [INTEGRACAO_BAF] Add Constraint [FK__INTEGRACA__CUSTO__5FF2C735] Foreign Key (CUSTO_PROPOSTA_ID) References CUSTO_PROPOSTA (CUSTO_PROPOSTA_ID)
Go
If Not Exists(Select 1 From sys.foreign_keys fk Where fk.parent_object_id = Object_Id('INTEGRACAO_BAF') And fk.name = 'FK__INTEGRACA__HISTO__60E6EB6E')
	Alter Table [INTEGRACAO_BAF] Add Constraint [FK__INTEGRACA__HISTO__60E6EB6E] Foreign Key (HISTORICO_CUSTO_PROPOSTA_ID) References HISTORICO_CUSTO_PROPOSTA (HISTORICO_CUSTO_PROPOSTA_ID)
Go
/*************** Check Constraints ****************/
/*************** Defaults ****************/
