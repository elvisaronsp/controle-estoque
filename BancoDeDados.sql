USE [master]
GO
CREATE DATABASE [controle-estoque]
GO
USE [controle-estoque]
GO
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [admin]
GO
CREATE TABLE [dbo].[grupo_produto] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [nvarchar](50) NULL,
	[ativo] [bit] NULL,
	CONSTRAINT [PK_grupo_produto] PRIMARY KEY ([id])
)
GO
CREATE TABLE [dbo].[perfil] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](20) NOT NULL,
	[ativo] [bit] NOT NULL,
	CONSTRAINT [PK_perfil] PRIMARY KEY ([id])
)
GO
CREATE TABLE [dbo].[unidade_medida] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](30) NOT NULL,
	[sigla] [varchar](3) NOT NULL,
	[ativo] [bit] NOT NULL,
	CONSTRAINT [PK_unidade_medida] PRIMARY KEY ([id])
)
GO
CREATE TABLE [dbo].[usuario] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	[login] [nvarchar](50) NOT NULL,
	[senha] [nvarchar](32) NOT NULL,
	[nome] [nvarchar](100) NOT NULL,
	[id_perfil] [int] NOT NULL,
	CONSTRAINT [PK_usuario] PRIMARY KEY ([id])
)
GO
CREATE TABLE [dbo].[perfil_usuario] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_perfil] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
 CONSTRAINT [PK_perfil_usuario] PRIMARY KEY ([id])
)
GO
CREATE TABLE [dbo].[marca_produto] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](50) NOT NULL,
	[ativo] [bit] NOT NULL,
	CONSTRAINT [PK_marca_produto] PRIMARY KEY ([id])
)
GO
CREATE TABLE [dbo].[local_armazenamento] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](50) NOT NULL,
	[ativo] [bit] NOT NULL,
	CONSTRAINT [PK_local_armazenamento] PRIMARY KEY ([id])
)
GO
CREATE TABLE [dbo].[pais] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](30) NOT NULL,
	[codigo] [varchar](3) NOT NULL,
	[ativo] [bit] NOT NULL,
	CONSTRAINT [PK_pais] PRIMARY KEY ([id])
)
GO
CREATE TABLE [dbo].[estado] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](30) NOT NULL,
	[uf] [varchar](2) NOT NULL,
	[ativo] [bit] NOT NULL,
	[id_pais] [int] NOT NULL,
	CONSTRAINT [PK_estado] PRIMARY KEY ([id])
)
GO
CREATE TABLE [dbo].[cidade] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](30) NOT NULL,
	[ativo] [bit] NOT NULL,
	[id_estado] [int] NOT NULL,
	CONSTRAINT [PK_cidade] PRIMARY KEY ([id])
)
GO
CREATE TABLE [dbo].[fornecedor] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](60) NOT NULL,
	[razao_social] [varchar](100) NULL,
	[num_documento] [varchar](20) NULL,
	[tipo] [int] NOT NULL,
	[telefone] [varchar](20) NOT NULL,
	[contato] [varchar](60) NOT NULL,
	[logradouro] [varchar](100) NOT NULL,
	[numero] [varchar](20) NOT NULL,
	[complemento] [varchar](100) NULL,
	[cep] [varchar](10) NULL,
	[id_pais] [int] NOT NULL,
	[id_estado] [int] NOT NULL,
	[id_cidade] [int] NOT NULL,
	[ativo] [bit] NOT NULL,
	CONSTRAINT [PK_fornecedor] PRIMARY KEY ([id])
)
GO
ALTER TABLE [dbo].[usuario] WITH CHECK ADD FOREIGN KEY([id_perfil]) REFERENCES [dbo].[perfil] ([id])
GO
ALTER TABLE [dbo].[perfil_usuario] WITH CHECK ADD FOREIGN KEY([id_perfil]) REFERENCES [dbo].[perfil] ([id])
GO
ALTER TABLE [dbo].[perfil_usuario] WITH CHECK ADD FOREIGN KEY([id_usuario]) REFERENCES [dbo].[usuario] ([id])
GO
ALTER TABLE [dbo].[estado] WITH CHECK ADD FOREIGN KEY([id_pais]) REFERENCES [dbo].[pais] ([id])
GO
ALTER TABLE [dbo].[cidade] WITH CHECK ADD FOREIGN KEY([id_estado]) REFERENCES [dbo].[estado] ([id])
GO
ALTER TABLE [dbo].[fornecedor] WITH CHECK ADD FOREIGN KEY([id_pais]) REFERENCES [dbo].[pais] ([id])
GO
ALTER TABLE [dbo].[fornecedor] WITH CHECK ADD FOREIGN KEY([id_estado]) REFERENCES [dbo].[estado] ([id])
GO
ALTER TABLE [dbo].[fornecedor] WITH CHECK ADD FOREIGN KEY([id_cidade]) REFERENCES [dbo].[cidade] ([id])
GO