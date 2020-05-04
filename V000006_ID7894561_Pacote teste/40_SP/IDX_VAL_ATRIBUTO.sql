
/****** Object:  Index [IDX_VAL_ATRIBUTO]    Script Date: 26/03/2020 15:00:21 ******/
CREATE NONCLUSTERED INDEX [IDX_VAL_ATRIBUTO] ON [dbo].[Tabela_Proposta_Atributo]
(
	[Tab_Atributo_Proposta_Id] ASC,
	[Tab_Status_Id] ASC
)
INCLUDE ( 	[Tabela_Proposta_Atributo_Id],
	[Tabela_Proposta_Destino_Id],
	[Val_Atributo]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



