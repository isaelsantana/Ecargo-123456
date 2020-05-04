
If Object_Id('HISTORICO_CUSTO_PROPOSTA') Is Null
	Create Table [HISTORICO_CUSTO_PROPOSTA] ([HISTORICO_CUSTO_PROPOSTA_ID] int Not Null Identity(1,1))
Go
 
	Alter Table [HISTORICO_CUSTO_PROPOSTA] Alter Column [HISTORICO_CUSTO_PROPOSTA_ID] int Not Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'CUSTO_PROPOSTA_ID' And [object_Id] = Object_Id('HISTORICO_CUSTO_PROPOSTA'))
	Alter Table [HISTORICO_CUSTO_PROPOSTA] Add [CUSTO_PROPOSTA_ID] int Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HISTORICO_CUSTO_PROPOSTA') And c.Name = 'CUSTO_PROPOSTA_ID' And Type_Name(c.system_type_id) = 'int' And c.max_length = 4 And c.[precision] = 10 And c.scale = 0 /*And c.is_nullable = 1*/)
		Alter Table [HISTORICO_CUSTO_PROPOSTA] Alter Column [CUSTO_PROPOSTA_ID] int Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'TAB_TIPO_CUSTO_PROPOSTA_ID' And [object_Id] = Object_Id('HISTORICO_CUSTO_PROPOSTA'))
	Alter Table [HISTORICO_CUSTO_PROPOSTA] Add [TAB_TIPO_CUSTO_PROPOSTA_ID] int Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HISTORICO_CUSTO_PROPOSTA') And c.Name = 'TAB_TIPO_CUSTO_PROPOSTA_ID' And Type_Name(c.system_type_id) = 'int' And c.max_length = 4 And c.[precision] = 10 And c.scale = 0 /*And c.is_nullable = 1*/)
		Alter Table [HISTORICO_CUSTO_PROPOSTA] Alter Column [TAB_TIPO_CUSTO_PROPOSTA_ID] int Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'MOEDA_ID' And [object_Id] = Object_Id('HISTORICO_CUSTO_PROPOSTA'))
	Alter Table [HISTORICO_CUSTO_PROPOSTA] Add [MOEDA_ID] int Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HISTORICO_CUSTO_PROPOSTA') And c.Name = 'MOEDA_ID' And Type_Name(c.system_type_id) = 'int' And c.max_length = 4 And c.[precision] = 10 And c.scale = 0 /*And c.is_nullable = 1*/)
		Alter Table [HISTORICO_CUSTO_PROPOSTA] Alter Column [MOEDA_ID] int Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'DATA_VALIDADE_INI' And [object_Id] = Object_Id('HISTORICO_CUSTO_PROPOSTA'))
	Alter Table [HISTORICO_CUSTO_PROPOSTA] Add [DATA_VALIDADE_INI] datetime Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HISTORICO_CUSTO_PROPOSTA') And c.Name = 'DATA_VALIDADE_INI' And Type_Name(c.system_type_id) = 'datetime' And c.max_length = 8 And c.[precision] = 23 And c.scale = 3 /*And c.is_nullable = 1*/)
		Alter Table [HISTORICO_CUSTO_PROPOSTA] Alter Column [DATA_VALIDADE_INI] datetime Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'DATA_VALIDADE_FIM' And [object_Id] = Object_Id('HISTORICO_CUSTO_PROPOSTA'))
	Alter Table [HISTORICO_CUSTO_PROPOSTA] Add [DATA_VALIDADE_FIM] datetime Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HISTORICO_CUSTO_PROPOSTA') And c.Name = 'DATA_VALIDADE_FIM' And Type_Name(c.system_type_id) = 'datetime' And c.max_length = 8 And c.[precision] = 23 And c.scale = 3 /*And c.is_nullable = 1*/)
		Alter Table [HISTORICO_CUSTO_PROPOSTA] Alter Column [DATA_VALIDADE_FIM] datetime Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'TAB_STATUS_ID' And [object_Id] = Object_Id('HISTORICO_CUSTO_PROPOSTA'))
	Alter Table [HISTORICO_CUSTO_PROPOSTA] Add [TAB_STATUS_ID] int Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HISTORICO_CUSTO_PROPOSTA') And c.Name = 'TAB_STATUS_ID' And Type_Name(c.system_type_id) = 'int' And c.max_length = 4 And c.[precision] = 10 And c.scale = 0 /*And c.is_nullable = 1*/)
		Alter Table [HISTORICO_CUSTO_PROPOSTA] Alter Column [TAB_STATUS_ID] int Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'TIPO_CUSTO' And [object_Id] = Object_Id('HISTORICO_CUSTO_PROPOSTA'))
	Alter Table [HISTORICO_CUSTO_PROPOSTA] Add [TIPO_CUSTO] char(1) Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HISTORICO_CUSTO_PROPOSTA') And c.Name = 'TIPO_CUSTO' And Type_Name(c.system_type_id) = 'char' And c.max_length = 1 And c.[precision] = 0 And c.scale = 0 /*And c.is_nullable = 1*/)
		Alter Table [HISTORICO_CUSTO_PROPOSTA] Alter Column [TIPO_CUSTO] char(1) Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'DATA_INCLUSAO' And [object_Id] = Object_Id('HISTORICO_CUSTO_PROPOSTA'))
	Alter Table [HISTORICO_CUSTO_PROPOSTA] Add [DATA_INCLUSAO] datetime Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HISTORICO_CUSTO_PROPOSTA') And c.Name = 'DATA_INCLUSAO' And Type_Name(c.system_type_id) = 'datetime' And c.max_length = 8 And c.[precision] = 23 And c.scale = 3 /*And c.is_nullable = 1*/)
		Alter Table [HISTORICO_CUSTO_PROPOSTA] Alter Column [DATA_INCLUSAO] datetime Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'USUARIO_ID' And [object_Id] = Object_Id('HISTORICO_CUSTO_PROPOSTA'))
	Alter Table [HISTORICO_CUSTO_PROPOSTA] Add [USUARIO_ID] int Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HISTORICO_CUSTO_PROPOSTA') And c.Name = 'USUARIO_ID' And Type_Name(c.system_type_id) = 'int' And c.max_length = 4 And c.[precision] = 10 And c.scale = 0 /*And c.is_nullable = 1*/)
		Alter Table [HISTORICO_CUSTO_PROPOSTA] Alter Column [USUARIO_ID] int Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'VAL_CARGA_20_DRY_S' And [object_Id] = Object_Id('HISTORICO_CUSTO_PROPOSTA'))
	Alter Table [HISTORICO_CUSTO_PROPOSTA] Add [VAL_CARGA_20_DRY_S] numeric(15,2) Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HISTORICO_CUSTO_PROPOSTA') And c.Name = 'VAL_CARGA_20_DRY_S' And Type_Name(c.system_type_id) = 'numeric' And c.max_length = 9 And c.[precision] = 15 And c.scale = 2 /*And c.is_nullable = 1*/)
		Alter Table [HISTORICO_CUSTO_PROPOSTA] Alter Column [VAL_CARGA_20_DRY_S] numeric(15,2) Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'VAL_CARGA_20_DRY_N' And [object_Id] = Object_Id('HISTORICO_CUSTO_PROPOSTA'))
	Alter Table [HISTORICO_CUSTO_PROPOSTA] Add [VAL_CARGA_20_DRY_N] numeric(15,2) Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HISTORICO_CUSTO_PROPOSTA') And c.Name = 'VAL_CARGA_20_DRY_N' And Type_Name(c.system_type_id) = 'numeric' And c.max_length = 9 And c.[precision] = 15 And c.scale = 2 /*And c.is_nullable = 1*/)
		Alter Table [HISTORICO_CUSTO_PROPOSTA] Alter Column [VAL_CARGA_20_DRY_N] numeric(15,2) Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'VAL_CARGA_40_DRY_S' And [object_Id] = Object_Id('HISTORICO_CUSTO_PROPOSTA'))
	Alter Table [HISTORICO_CUSTO_PROPOSTA] Add [VAL_CARGA_40_DRY_S] numeric(15,2) Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HISTORICO_CUSTO_PROPOSTA') And c.Name = 'VAL_CARGA_40_DRY_S' And Type_Name(c.system_type_id) = 'numeric' And c.max_length = 9 And c.[precision] = 15 And c.scale = 2 /*And c.is_nullable = 1*/)
		Alter Table [HISTORICO_CUSTO_PROPOSTA] Alter Column [VAL_CARGA_40_DRY_S] numeric(15,2) Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'VAL_CARGA_40_DRY_N' And [object_Id] = Object_Id('HISTORICO_CUSTO_PROPOSTA'))
	Alter Table [HISTORICO_CUSTO_PROPOSTA] Add [VAL_CARGA_40_DRY_N] numeric(15,2) Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HISTORICO_CUSTO_PROPOSTA') And c.Name = 'VAL_CARGA_40_DRY_N' And Type_Name(c.system_type_id) = 'numeric' And c.max_length = 9 And c.[precision] = 15 And c.scale = 2 /*And c.is_nullable = 1*/)
		Alter Table [HISTORICO_CUSTO_PROPOSTA] Alter Column [VAL_CARGA_40_DRY_N] numeric(15,2) Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'VAL_CARGA_20_REEFER_S' And [object_Id] = Object_Id('HISTORICO_CUSTO_PROPOSTA'))
	Alter Table [HISTORICO_CUSTO_PROPOSTA] Add [VAL_CARGA_20_REEFER_S] numeric(15,2) Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HISTORICO_CUSTO_PROPOSTA') And c.Name = 'VAL_CARGA_20_REEFER_S' And Type_Name(c.system_type_id) = 'numeric' And c.max_length = 9 And c.[precision] = 15 And c.scale = 2 /*And c.is_nullable = 1*/)
		Alter Table [HISTORICO_CUSTO_PROPOSTA] Alter Column [VAL_CARGA_20_REEFER_S] numeric(15,2) Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'VAL_CARGA_20_REEFER_N' And [object_Id] = Object_Id('HISTORICO_CUSTO_PROPOSTA'))
	Alter Table [HISTORICO_CUSTO_PROPOSTA] Add [VAL_CARGA_20_REEFER_N] numeric(15,2) Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HISTORICO_CUSTO_PROPOSTA') And c.Name = 'VAL_CARGA_20_REEFER_N' And Type_Name(c.system_type_id) = 'numeric' And c.max_length = 9 And c.[precision] = 15 And c.scale = 2 /*And c.is_nullable = 1*/)
		Alter Table [HISTORICO_CUSTO_PROPOSTA] Alter Column [VAL_CARGA_20_REEFER_N] numeric(15,2) Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'VAL_CARGA_40_REEFER_S' And [object_Id] = Object_Id('HISTORICO_CUSTO_PROPOSTA'))
	Alter Table [HISTORICO_CUSTO_PROPOSTA] Add [VAL_CARGA_40_REEFER_S] numeric(15,2) Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HISTORICO_CUSTO_PROPOSTA') And c.Name = 'VAL_CARGA_40_REEFER_S' And Type_Name(c.system_type_id) = 'numeric' And c.max_length = 9 And c.[precision] = 15 And c.scale = 2 /*And c.is_nullable = 1*/)
		Alter Table [HISTORICO_CUSTO_PROPOSTA] Alter Column [VAL_CARGA_40_REEFER_S] numeric(15,2) Null
Go
If Not Exists (Select 1 From sys.columns Where Name = 'VAL_CARGA_40_REEFER_N' And [object_Id] = Object_Id('HISTORICO_CUSTO_PROPOSTA'))
	Alter Table [HISTORICO_CUSTO_PROPOSTA] Add [VAL_CARGA_40_REEFER_N] numeric(15,2) Null
Else 
	If Not Exists(Select * From sys.columns c Where c.[object_id] = Object_Id('HISTORICO_CUSTO_PROPOSTA') And c.Name = 'VAL_CARGA_40_REEFER_N' And Type_Name(c.system_type_id) = 'numeric' And c.max_length = 9 And c.[precision] = 15 And c.scale = 2 /*And c.is_nullable = 1*/)
		Alter Table [HISTORICO_CUSTO_PROPOSTA] Alter Column [VAL_CARGA_40_REEFER_N] numeric(15,2) Null
Go
If Not Exists(Select 1 From sys.key_constraints kc Where parent_object_id = Object_Id('HISTORICO_CUSTO_PROPOSTA') And kc.[type] = 'PK')
	Alter Table HISTORICO_CUSTO_PROPOSTA Add Constraint PK__HISTORIC__19420D96037677D8 Primary Key (HISTORICO_CUSTO_PROPOSTA_ID)
Go
/******************************************************/
/******************** Foreign Keys ********************/
/******************************************************/

/*************** Check Constraints ****************/
/*************** Defaults ****************/


