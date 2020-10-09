USE [AtencionClientes]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Vivian>
-- Create date: <07/10/2020>
-- Description:	<Determinar la cola del menor tiempo de espera>
-- =============================================
CREATE FUNCTION [dbo].[DeterminarColaMenorEspera] 
(	
) 
RETURNS 
		@AtencionReturn table(
		TipoCola int not null,
		FechaHoraSalida datetime not null default 0		
	)
AS
BEGIN

	declare @Atencion table(
		TipoCola int not null,
		FechaHoraSalida datetime not null default 0		
	)

	declare @ClientesNoAtendidos table(
		TipoCola int not null,
		FechaHoraSalida datetime not null
	);	

	--Se inicializan los datos para cuando no existan clientes
	insert into @Atencion (TipoCola, FechaHoraSalida)
	select 1, 0 union all
	select 2, 0

	insert into @ClientesNoAtendidos (TipoCola, FechaHoraSalida)	
	select c.IdTipoCola, MAX(c.FechaHoraSalida) FechaHoraSalida
	from Cola c		
	where c.IdEstado NOT IN (3) --Sólo clientes que no han sido atendidos
	group by c.IdTipoCola
	
	update a
	set a.FechaHoraSalida = c.FechaHoraSalida		
	from @ClientesNoAtendidos  c	
	inner join @Atencion a on (a.TipoCola = c.TipoCola)	

	insert into @AtencionReturn (TipoCola, FechaHoraSalida)
	select  top 1 TipoCola, FechaHoraSalida 
	from @Atencion a
	order by FechaHoraSalida, TipoCola

	RETURN 
	
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[IdCliente] [int] IDENTITY(1,1) NOT NULL,
	[Identificacion] [nvarchar](13) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cola](
	[IdCola] [int] IDENTITY(1,1) NOT NULL,
	[IdTipoCola] [int] NOT NULL,
	[IdCliente] [int] NOT NULL,
	[HoraEntrada] [datetime] NOT NULL,
	[FechaHoraAtencion] [datetime] NOT NULL,
	[FechaHoraSalida] [datetime] NOT NULL,
	[IdEstado] [int] NOT NULL,
 CONSTRAINT [PK_Cola] PRIMARY KEY CLUSTERED 
(
	[IdCola] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estado](
	[IdEstado] [int] IDENTITY(1,1) NOT NULL,
	[Estado] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Estado] PRIMARY KEY CLUSTERED 
(
	[IdEstado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoCola](
	[IdTipoCola] [int] IDENTITY(1,1) NOT NULL,
	[Duracion] [int] NOT NULL,
 CONSTRAINT [PK_TipoCola] PRIMARY KEY CLUSTERED 
(
	[IdTipoCola] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cola] ADD  DEFAULT ((1)) FOR [IdEstado]
GO
ALTER TABLE [dbo].[Cola]  WITH CHECK ADD FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Cliente] ([IdCliente])
GO
ALTER TABLE [dbo].[Cola]  WITH CHECK ADD FOREIGN KEY([IdEstado])
REFERENCES [dbo].[Estado] ([IdEstado])
GO
ALTER TABLE [dbo].[Cola]  WITH CHECK ADD FOREIGN KEY([IdTipoCola])
REFERENCES [dbo].[TipoCola] ([IdTipoCola])
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ========================================================================================================
-- Author:		<Vivian Cabrera>
-- Create date: <08/10/2020>
-- Description:	<Actualizar los tipos de estados en la Cola, 1- En Espera, 2- En Atención, 3- Atendido>
-- ========================================================================================================
CREATE PROCEDURE [dbo].[ActualizarEstadosAtencion]

	@FechaMomento DateTime
AS
BEGIN
	
	SET NOCOUNT ON;	

    -- Se actualiza el estado de los registros según el momento
	update c
	set c.IdEstado = case 
						when   @FechaMomento > c.FechaHoraSalida then 3
						when   @FechaMomento BETWEEN c.FechaHoraAtencion AND c.FechaHoraSalida then 2
						else   c.IdEstado
					end
	from dbo.Cola c

END
GO

--Insertar datos de nomencladores
INSERT INTO [dbo].[TipoCola]
           ([Duracion])
     VALUES
           (2),(3)
GO

INSERT INTO [dbo].[Estado]
           ([Estado])
     VALUES
           ('En espera'), ('En atención'), ('Atendido')
GO
