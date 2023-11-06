# Relatório de Configuração de Roteamento Estático

## Configuração

O código fornecido define três máquinas virtuais (VMs) usando o Vagrant, uma ferramenta para a criação e gerenciamento de ambientes de desenvolvimento virtualizados. As VMs são configuradas da seguinte maneira:

1. **vm1**: Esta VM é configurada para usar a imagem "ubuntu/focal64" e é configurada como uma rede pública, atuando como uma ponte na interface "enp0s3". Além disso, durante a provisão, a VM atualiza seus pacotes, instala o `tcpdump` (uma ferramenta de captura de pacotes de rede), inicia uma captura de pacotes na interface "enp0s3" e instala o `traceroute` (uma ferramenta de diagnóstico de rede para rastrear a rota que os pacotes IP levam para chegar a um determinado host).

2. **web**: Esta VM também usa a imagem "ubuntu/focal64", mas é configurada como uma rede privada com o endereço IP "192.168.50.5". O nome do host é definido como "web". Durante a provisão, um script shell chamado "web.sh" é executado.

3. **db**: Semelhante à VM "web", esta VM usa a imagem "ubuntu/focal64" e é configurada como uma rede privada com o endereço IP "192.168.60.5". O nome do host é definido como "db". Durante a provisão, um script shell chamado "db.sh" é executado.

## Análise do Roteamento Estático

O roteamento estático é uma forma de roteamento que ocorre quando um roteador usa uma rota manualmente configurada, que é inserida na tabela de roteamento. As rotas estáticas são rotas que são inseridas manualmente pelo administrador da rede.

### Vantagens do Roteamento Estático

- **Simplicidade**: O roteamento estático é fácil de configurar e não requer nenhum conhecimento complexo de protocolos de roteamento.
- **Segurança**: Como as rotas são definidas manualmente, há menos chances de rotas indesejadas serem propagadas através da rede.
- **Previsibilidade**: As rotas estáticas são previsíveis, pois não mudam a menos que o administrador da rede as altere.

### Desvantagens do Roteamento Estático

- **Escalabilidade**: O roteamento estático pode não ser adequado para redes grandes, pois a adição ou alteração de rotas pode ser um processo demorado e propenso a erros.
- **Manutenção**: Se uma rede muda frequentemente, manter a tabela de roteamento atualizada pode ser um desafio.
- **Falha de Rede**: O roteamento estático não se adapta bem às mudanças na topologia da rede. Se um link falhar, o roteador não aprenderá uma nova rota e o tráfego será interrompido.

Em comparação, o roteamento dinâmico, onde os roteadores trocam informações de rota e são capazes de alterar suas tabelas de roteamento automaticamente, pode ser mais adequado para redes maiores e mais complexas. No entanto, eles também podem ser mais difíceis de configurar e gerenciar, e podem apresentar suas próprias questões de segurança. A escolha entre roteamento estático e dinâmico dependerá das necessidades específicas da rede.

# Relatório de Análise de Tráfego de Rede

## Introdução

O `tcpdump` é uma ferramenta poderosa que permite capturar e analisar o tráfego de rede. Ele captura os pacotes que passam por uma determinada interface de rede e pode exibir esses pacotes de uma forma que os humanos podem entender.

No contexto das máquinas virtuais configuradas, o `tcpdump` foi instalado na VM "vm1" e configurado para capturar pacotes na interface "enp0s3". A captura de pacotes é salva em um arquivo chamado "captura.pcap".

## Análise de Pacotes

Para analisar os pacotes capturados, você pode usar uma ferramenta como o Wireshark para abrir o arquivo "captura.pcap". Isso permitirá que você veja detalhes sobre cada pacote, incluindo:

- O endereço IP de origem e destino
- O protocolo usado (por exemplo, TCP, UDP, ICMP)
- O tamanho do pacote
- Informações sobre a camada de transporte, como a porta de origem e destino para pacotes TCP ou UDP
- Qualquer dado contido no pacote

## Resultados

- Pacotes com um endereço IP de origem de "192.168.50.5" são provavelmente da VM "web".
- Pacotes com um endereço IP de origem de "192.168.60.5" são provavelmente da VM "db".
- Você pode ver a comunicação entre as VMs observando pacotes que têm um desses endereços IP como origem e o outro como destino.
- Se você ver muitos pacotes ICMP, isso pode indicar que há uma quantidade significativa de pings ou outros tipos de mensagens de controle de rede sendo enviados.
- Se você ver pacotes TCP com a flag SYN, isso indica uma tentativa de estabelecer uma conexão TCP.

## Conclusão

A análise de pacotes de rede pode fornecer insights valiosos sobre o tráfego de rede e pode ajudar a identificar problemas de rede, como congestionamento, ataques de negação de serviço ou configurações de rede inadequadas. No entanto, também requer um bom entendimento dos protocolos de rede e pode ser um processo demorado se houver uma grande quantidade de tráfego para analisar.