
/****** Object:  Index [Idx_TPAI_TPD]    Script Date: 26/03/2020 14:57:30 ******/
CREATE NONCLUSTERED INDEX [Idx_TPAI_TPD] ON [dbo].[Tabela_Proposta_Atributo]
(
	[Tabela_Proposta_Atributo_Ident] ASC,
	[Tabela_Proposta_Destino_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


