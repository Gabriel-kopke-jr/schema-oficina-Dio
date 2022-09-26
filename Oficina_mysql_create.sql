CREATE TABLE `Clientes` (
	`idCliente` bigint NOT NULL AUTO_INCREMENT,
	`Primeiro_nome` varchar(255) NOT NULL,
	`Rua` varchar(255) NOT NULL,
	`bairro` varchar(255) NOT NULL,
	`cidade` varchar(255) NOT NULL,
	`estado` varchar(255) NOT NULL,
	`nome_meio` varchar(255) NOT NULL,
	`ultimo_nome` varchar(255) NOT NULL,
	`tipo_documento` enum("cpf","cnpj") NOT NULL,
	`nr_documento` varchar(255) NOT NULL UNIQUE,
	PRIMARY KEY (`idCliente`)
);

CREATE TABLE `Veiculos` (
	`idVeiculo` bigint NOT NULL AUTO_INCREMENT,
	`Cor` varchar(255) NOT NULL,
	`Fabricante` varchar(255) NOT NULL,
	`Ano` year(4) NOT NULL,
	`modelo` varchar(255) NOT NULL,
	`Placa` varchar(255) NOT NULL UNIQUE,
	`cliente` varchar(255) NOT NULL,
	`Cliente_idCliente` varchar(255) NOT NULL,
	`Tipo_veiculo` enum("carro","moto","caminhao") NOT NULL,
	PRIMARY KEY (`idVeiculo`)
);

CREATE TABLE `OS` (
	`idOS` bigint NOT NULL AUTO_INCREMENT,
	`nrOS` bigint NOT NULL AUTO_INCREMENT,
	`Data_Emissao` DATE NOT NULL,
	`Valor` numeric(10) NOT NULL,
	`Data_Conclusao` DATE NOT NULL,
	`Veiculo_idVeiculo` bigint NOT NULL,
	`Mecanicos_idMecanicos` bigint NOT NULL,
	`MDB-IdServico` bigint NOT NULL,
	`Orcamento` numeric(5) NOT NULL,
	`Cliente_idCliente` bigint NOT NULL,
	PRIMARY KEY (`idOS`)
);

CREATE TABLE `Peca` (
	`idPeça` bigint NOT NULL AUTO_INCREMENT,
	`valor` numeric(4) NOT NULL,
	`descricao` varchar(45) NOT NULL,
	`modelo` varchar(45) NOT NULL,
	`fabricante` varchar(255) NOT NULL,
	PRIMARY KEY (`idPeça`)
);

CREATE TABLE `Solicita` (
	`OS_idOS` bigint NOT NULL,
	`Peca_IdPeca` bigint NOT NULL,
	`Quantidade` bigint NOT NULL
);

CREATE TABLE `mao-de-obra` (
	`idFuncionario` bigint NOT NULL AUTO_INCREMENT,
	`matricula` varchar(255) NOT NULL UNIQUE,
	`cpts` varchar(255) NOT NULL UNIQUE,
	`Pri_nome` varchar(255) NOT NULL,
	`Meio_nome` varchar(255) NOT NULL,
	`Ultimo_nome` varchar(255) NOT NULL,
	`Rua` varchar(255) NOT NULL,
	`Bairro` varchar(255) NOT NULL,
	`cidade` varchar(255) NOT NULL,
	`Estado` varchar(255) NOT NULL,
	'salario' float(6,2) not null,
	PRIMARY KEY (`idFuncionario`)
);

CREATE TABLE `funcionario` (
	`idFuncionario` bigint NOT NULL,
	`departamento` varchar(255) NOT NULL,
	`cargo` varchar(255) NOT NULL,
	PRIMARY KEY (`idFuncionario`)
);

CREATE TABLE `mecanico` (
	`idfuncionario` bigint NOT NULL,
	`idmecanico` bigint NOT NULL AUTO_INCREMENT,
	`turno` enum("manha","tarde","noite") NOT NULL,
	PRIMARY KEY (`idfuncionario`,`idmecanico`)
);

CREATE TABLE `Os-mecanico` (
	`idmecanico` bigint NOT NULL,
	`idOs` bigint NOT NULL,
	PRIMARY KEY (`idmecanico`,`idOs`)
);

CREATE TABLE `mecanico-veiculo` (
	`idMecanico` bigint NOT NULL,
	`idVeiculo` bigint NOT NULL,
	PRIMARY KEY (`idMecanico`,`idVeiculo`)
);

ALTER TABLE `Veiculos` ADD CONSTRAINT `Veiculos_fk0` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `Clientes`(`idCliente`);

ALTER TABLE `OS` ADD CONSTRAINT `OS_fk0` FOREIGN KEY (`Veiculo_idVeiculo`) REFERENCES `Veiculos`(`idVeiculo`);

ALTER TABLE `OS` ADD CONSTRAINT `OS_fk1` FOREIGN KEY (`Mecanicos_idMecanicos`) REFERENCES `Mecânicos`(`idMecânico`);

ALTER TABLE `OS` ADD CONSTRAINT `OS_fk2` FOREIGN KEY (`MDB-IdServico`) REFERENCES `Mao de Obra`(`idServico`);

ALTER TABLE `OS` ADD CONSTRAINT `OS_fk3` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `Clientes`(`idCliente`);

ALTER TABLE `Solicita` ADD CONSTRAINT `Solicita_fk0` FOREIGN KEY (`OS_idOS`) REFERENCES `OS`(`idOS`);

ALTER TABLE `Solicita` ADD CONSTRAINT `Solicita_fk1` FOREIGN KEY (`Peca_IdPeca`) REFERENCES `Peça`(`idPeça`);

ALTER TABLE `funcionario` ADD CONSTRAINT `funcionario_fk0` FOREIGN KEY (`idFuncionario`) REFERENCES `mao-de-obra`(`idFuncionario`);

ALTER TABLE `mecanico` ADD CONSTRAINT `mecanico_fk0` FOREIGN KEY (`idfuncionario`) REFERENCES `mao-de-obra`(`idFuncionario`);

ALTER TABLE `Os-mecanico` ADD CONSTRAINT `Os-mecanico_fk0` FOREIGN KEY (`idmecanico`) REFERENCES `mecanico`(`idmecanico`);

ALTER TABLE `Os-mecanico` ADD CONSTRAINT `Os-mecanico_fk1` FOREIGN KEY (`idOs`) REFERENCES `OS`(`idOS`);

ALTER TABLE `mecanico-veiculo` ADD CONSTRAINT `mecanico-veiculo_fk0` FOREIGN KEY (`idMecanico`) REFERENCES `mecanico`(`idmecanico`);

ALTER TABLE `mecanico-veiculo` ADD CONSTRAINT `mecanico-veiculo_fk1` FOREIGN KEY (`idVeiculo`) REFERENCES `Veiculos`(`idVeiculo`);


------ listando todos os funcionários e seus registros

select concat(Pri_nome, " ",Meio_nome," ",Ultimo_nome ) as nome_funcionario, cpts as CPTS, concat(Rua,"-",Bairro,"-",cidade,"-",Estado)   from mao-de-obra;

------- listando os veiculos que foram atendidos

select * from Veiculos;

------ listando as OS mais recentes

select * from Os order by  Data_Emissao desc;

--- listando as peças que possuem quantidade maior que 100

select * from from peca where qnt > 100;

---- Especifação da os para cliente 

select os.nrOS as "numero de os", concat(clientes.Pri_nome, " ",clientes.Meio_nome," ",clientes.Ultimo_nome ) as "Cliente",
	os.Data_Emissao as "data emissão", os.Data_Conclusao as "Prazo de conclusão",( select
		 concat(veiculos.modelo," ", veiculos.cor," ",veiculos.ano) as "modelo", from veiculos  join os on idVeiculo = Veiculo_idVeiculo   )
	veiculos.placa as "placa"
  from os,  join clientes on     Cliente_idCliente = idCliente;

  ----- Contando emrpegados que possuem salario acima de 3000

  select count(*) from mao-de-obra mb
	having mb.salario > 3000.00










