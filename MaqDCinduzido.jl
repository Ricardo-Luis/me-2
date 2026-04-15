### A Pluto.jl notebook ###
# v0.20.21

#> [frontmatter]
#> chapter = 1
#> section = 1
#> order = 1
#> image = "https://github.com/Ricardo-Luis/notebooks/blob/main/ME2/images/commutator.jpg?raw=true"
#> title = "Máquina CC: induzido, RMI, comutação"
#> tags = ["lecture", "module2"]
#> date = "2025-09-14"
#> layout = "layout.jlhtml"
#> description = "As observações laboratoriais deste trabalho incidem principalmente sobre o rotor da máquina de corrente contínua, com os seguintes objetivos: esquematizar os enrolamentos do induzido; observar a reação magnética do induzido; e analisar o processo de comutação."
#> 
#>     [[frontmatter.author]]
#>     name = "Ricardo Luís"
#>     url = "https://ricardo-luis.github.io"

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 3b461ddf-3b4b-457b-9f9c-f606d8b260aa
using PlutoUI, Handcalcs, PlutoTeachingTools
#=
Short packages description:
 PlutoUI.jl, to add interactivity objects to notebook
 PlutoTeachingTools.jl, to enhance the notebook
 Handcalcs.jl, interactive engineering calculations with symbolic equation display
=#

# ╔═╡ 91180300-0b49-4211-9ad3-12fd0785f518
TwoColumnWideLeft(md"`MaqDCinduzido.jl`", md"`Last update: 15·04·2026`")

# ╔═╡ 4e3917b0-4458-11ef-2b69-bd55e90578e0
md"""
---
$\text{RELATÓRIO}$ 

$$\begin{gather}
\colorbox{Bittersweet}{\textcolor{white}{\textbf{Observação dos aspetos construtivos e do funcionamento}}} \\
\colorbox{Bittersweet}{\textcolor{white}{\textbf{da}}} \\
\colorbox{Bittersweet}{\textcolor{white}{\textbf{Máquina Elétrica de Corrente Contínua}}}
\end{gather}$$
---
"""

# ╔═╡ bb397679-8965-4486-8c22-80a973b00bd1
aside((md"""
!!! info "Nota:"
	Este relatório foi preparado como guia para a **aula de observação**. Algumas secções estão em branco para que possam registar as vossas observações e notas durante a sessão.
	
	As partes a completar estão indicadas ao longo do relatório com o símbolo 📌.
"""), v_offset=- 80)

# ╔═╡ 2239ebd6-bb9c-4e48-bf2b-78557cd8f7e6
md"""
# 1 - Introdução
"""

# ╔═╡ 14c7e7d9-5e3f-4680-a625-cfa81ba48e69
md"""
A máquina de Corrente Contínua (CC) distingue-se das restantes máquinas elétricas rotativas devido à presença do coletor e escovas. Estes componentes operam como um retificador mecânico de contacto deslizante das forças eletromotrizes alternadas geradas nos condutores do enrolamento induzido (rotor) em movimento, sob um campo magnético constante.\

O coletor faz a ligação elétrica com o **enrolamento do induzido** através das suas lâminas. O conjunto lâminas e escovas realiza a retificação de onda completa da força eletromotriz induzida nas bobinas do enrolamento induzido. Este processo é designado por **comutação**. Como resultado, quando o induzido da máquina CC se encontra num circuito fechado, verifica-se uma corrente unidirecional, entre escova(s) positiva(s) e escova(s) negativa(s) com o circuito externo, mas no interior do enrolamento induzido a corrente vai "comutando", ou seja, mudando de sentido à medida que as lâminas associadas às secções vão sendo curto-circuitadas pelas escovas.\

Quando circula um valor considerável de corrente no enrolamento induzido tanto no funcionamento como gerador como motor, ocorre a **reação magnética do induzido** que tem algumas implicações no funcionamento da máquina CC e que são evidenciadas nesta aula de observação no Lab. de Máquinas Elétricas.
"""

# ╔═╡ 9ef12029-565b-4a7c-8075-da777a76159d


# ╔═╡ dfa3294f-a708-4ce8-afcd-b75d02ade322
md"""
## 1.1 - Objetivos
"""

# ╔═╡ 951470b1-3506-4d92-898d-5b3f996e0bab
md"""
As observações laboratoriais deste trabalho têm como foco principal, o rotor da máquina CC, com os seguintes objetivos: 
- Esquematização dos enrolamentos do induzido;
- Observação da reação magnética do induzido;
- Observação do processo da comutação.
"""

# ╔═╡ 09eb0bd2-d889-4969-a426-5d76b394dd4b
aside((md"![](https://github.com/Ricardo-Luis/me-2/blob/d32997eec06d150a8f0bf275d8c2d46f6fe6a732/images/MaqDCinduzido/armature_winders.jpg?raw=true)\

Fig. 1: Bobinadores executando a montagem de um enrolamento induzido, [^Kennedy_1903].

"),v_offset=100)

# ╔═╡ f5802767-8a84-4a79-a949-2c873e47af28
md"""
## 1.2 - Enrolamentos do induzido
"""

# ╔═╡ ff0e1c6b-6c1a-4d27-b986-a2c003b27ab3
md"""
Existem dois tipos de bobinagem do induzido para disposições em tambor:
- enrolamento imbricado
- enrolamento ondulado

Estes enrolamentos podem ser simples ou múltiplos (geramente duplos ou triplos). É possível percepcionar a multiplicidade do enrolamento do induzido pela largura das escovas, medida em número de lâminas do coletor abrangidas na superfície de contacto entre uma escova e o coletor. 

No presente trabalho, serão executados apenas enrolamentos simples. Em vez de utilizar um rotor real, _e.g._ Fig. 1, será empregue um modelo de madeira, utilizando um cordel para simular a sequência de execução do enrolamento induzido.
"""

# ╔═╡ de94ef0e-5ff7-4233-b38b-ad6ad6ec8171
md"""
Para o dimensionamento de um enrolamento induzido são necessários os seguintes parâmetros:

 $\qquad c$: Número de lâminas do coletor;\
 $\qquad s$: Número de secções (bobinas) no induzido; $\qquad\:\: s=c$\
 $\qquad la$: Número de lados ativos no induzido; $\qquad\qquad la=2\,s$\
 $\qquad N_s$: Número de condutores por lado ativo;\
 $\qquad p$: Número de par de polos;\
 $\qquad k$: Número de cavas do induzido;\
 $\qquad z$: Número de condutores ativos no induzido; $\qquad\: z=la\,N_s=2\,s\,N_s$\
 $\qquad y_p$: Passo polar. Número de lados ativos entre dois polos adjacentes;\
 $\qquad y_1$: Passo da secção ou passo posterior. Número de lados ativos entre a ida e o retorno da mesma secção;\
 $\qquad y_2$: Passo da ligação ou passo anterior. Número de lados ativos entre o retorno de uma secção e a ida da secção seguinte;\
 $\qquad y$: Passo do enrolamento ou passo resultante. Número de lados ativos entre a ida de uma secção e a ida da secção seguinte;\
 $\qquad y_c$: Passo do coletor. Número de lâminas no coletor entre as duas ligações da mesma secção;\
 $\qquad u$: Número de lados ativos por cava;\
 $\qquad y_{1k}$: Passo da secção ou passo posterior $(y_1)$, em número de cavas;\
 $\qquad y_{2k}$: Passo da ligação ou passo anterior $(y_2)$, em número de cavas.

"""

# ╔═╡ b7a4e10d-c775-43a1-9dd5-172533d979ce


# ╔═╡ 1dac7191-d776-46dd-8178-dd1e7685533c
md"""
> **Nota:**
> O dimensionamento da bobinagem do enrolamento induzido exemplificado na [secção 2A.2 para imbricado](#2A.2---Dimensionamento:-enrolamento-imbricado-simples) e na [secção 2A.3 para ondulado](#2A.3---Dimensionamento:-enrolamento-ondulado-simples) não faz parte do programa da unidade curricular. Serve o propósito de, durante a aula de observação, mostrar as diferenças de colocação do enrolamento induzido no núcleo ferromagnético e as implicações no funcionamento das máquinas CC.
	
"""

# ╔═╡ 1e7bf323-80aa-4d3e-92ac-fa45b5992d49


# ╔═╡ 9a85c027-b125-407e-ad2a-05ed3df3720a
md"""
### 1.2.1 - Enrolamento imbricado
"""

# ╔═╡ 43e643d4-9a85-4b5a-ac50-629a25bef0d2
md"""
A Fig.2 apresenta o exemplo do desenvolvimento de um enrolamento imbricado simples de uma máquina CC de 2 pares de polos e um coletor de 24 lâminas.
"""

# ╔═╡ a9ae848a-2d79-44f9-8a46-9371b916004d
let
# raw_url -> on github draw.io file click the "Raw" button (top right, of file view) and then copy the URL from your browser address bar:	
   raw_url = "https://raw.githubusercontent.com/Ricardo-Luis/me-2/refs/heads/main/draw/MaqDCinduzido/DC.LapWinding.drawio"
   
# Adjustable settings:
   iframe_width = 690
   iframe_height = 710
# 1 = fit diagram to iframe size (keeps aspect ratio); 0 = original diagram size
   fit = 0  

# viewer_url build   
   viewer_url = "https://viewer.diagrams.net/?highlight=0000ff&edit=_blank&layers=1&nav=1&fit=$(fit)#U" * raw_url

# HTML
   HTML("""
   <div style="text-align: center;">
       <iframe frameborder="0" 
               style="width:$(iframe_width)px; height:$(iframe_height)px; border: 1px solid #ddd;" 
               src="$(viewer_url)">
       </iframe>
   </div>
   """)
end

# ╔═╡ e1245c3a-cd1e-416f-ac23-e612b8be5157
md"""
Fig. 2: Planificação de um enrolamento impbricado simples.
"""

# ╔═╡ 7c117066-973e-466d-92aa-f507e69affd6
md"""
Uma máquina com enrolamento induzido imbricado utiliza um número de escovas igual ao número de polos da máquina. Assim, no presente exemplo tém-se um par de escovas positivas e um par de escovas negativas, pelo que a corrente no interior do enrolamento do induzido divide-se por 4 caminhos em paralelo.
"""

# ╔═╡ 63820b95-7bf3-40a0-b758-b8eefe194ff0


# ╔═╡ e74e74fd-0c8b-445b-aaa5-9df365b8c589
md"""
### 1.2.2 - Enrolamento ondulado
"""

# ╔═╡ 1e6969b2-da36-4cbb-a7a8-47468716c86b
md"""
A Fig.3 apresenta o exemplo do desenvolvimento de um enrolamento ondulado simples da mesma máquina CC da Fig. 2.
"""

# ╔═╡ 904019a5-542f-4a77-9db2-979caa67d261
let
# raw_url -> on github draw.io file click the "Raw" button (top right, of file view) and then copy the URL from your browser address bar:	
   raw_url = "https://raw.githubusercontent.com/Ricardo-Luis/me-2/refs/heads/main/draw/MaqDCinduzido/DC.WaveWinding.drawio"
   
# Adjustable settings:
   iframe_width = 690
   iframe_height = 710
# 1 = fit diagram to iframe size (keeps aspect ratio); 0 = original diagram size
   fit = 0  

# viewer_url build   
   viewer_url = "https://viewer.diagrams.net/?highlight=0000ff&edit=_blank&layers=1&nav=1&fit=$(fit)#U" * raw_url

# HTML
   HTML("""
   <div style="text-align: center;">
       <iframe frameborder="0" 
               style="width:$(iframe_width)px; height:$(iframe_height)px; border: 1px solid #ddd;" 
               src="$(viewer_url)">
       </iframe>
   </div>
   """)
end

# ╔═╡ 7b102a0a-c257-47d5-aabc-a267af9bd5a5
md"""
Fig. 3: Planificação de um enrolamento ondulado simples.
"""

# ╔═╡ dd4ece32-e186-46ea-a1fc-a31dc8f80388
md"""
Note-se, no entanto, que um enrolamento ondulado terá apenas um par de escovas, independente do número de polos da máquina. Tal significa que a corrente no interior do induzido divide-se apenas por 2 caminhos em paralelo. No entanto, como as secções do enrolamento induzido na tipologia ondulado são colocadas em série, resulta uma maior força eletromotriz induzida entre as escovas, comparativamente com as secções colocadas no modo imbricado.
"""

# ╔═╡ eaef98e4-c79f-4932-8b7c-32a90fa664db
aside((md"![](https://github.com/Ricardo-Luis/me-2/blob/d32997eec06d150a8f0bf275d8c2d46f6fe6a732/images/MaqDCinduzido/armature_reaction.jpg?raw=true)\

Fig. 4: Distorção do campo magnético num induzido em anel de Gramme, [^Audel_1917]


"),v_offset=100)

# ╔═╡ 3571ba78-44b7-489a-a2bd-c4841c931879
md"""
## 1.3 - Reação magnética o induzido
"""

# ╔═╡ 2b9ef51e-bfe4-4a77-9e04-f1eea7320f99
md"""
Na máquina CC em vazio ou com corrente do induzido muito baixa, o campo magnético produzido no enrolamento indutor (enrolamento de excitação) que envolve os polos magnéticos é simétrico em relação à linha dos polos (linha de **S** a **N** da Fig. 2). Como a permeabilidade magnética de um núcleo ferromagnético é muito superior à do ar, as linhas de campo tendem a ser perpendiculares às superfícies dos núcleos ferromagnéticos.\

Quando circula corrente no enrolamento do rotor, são produzidas linhas de campo magnético em torno do enrolamento do induzido. Na sobreposição dos dois campos magnéticos, indutor e induzido, obtém-se um campo magnético resultante, caracterizado por uma distribuição assimétrica das linhas de fluxo magnético nos núcleos ferromagnéticos. A Fig. 2 ilustra o efeito do campo resultante, verificando-se uma concentração de linhas de fluxo numa parte do polo magnético e uma rarefação na outra parte. No polo oposto, ocorre o mesmo efeito de forma invertida segundo a linha dos polos.\

Assim, o campo magnético resultante que a atravessa o enrolamento induzido, quando este está em carga, apresenta-se com elevada distorção. Isso implica uma movimentação do plano das escovas para que fique perpendicular à distribuição das linhas de fluxo. Este processo denomina-se por **calagem das escovas**, posicionando-as na Linha Neutra Real, que é dependente do valor da corrente do induzido. 
"""

# ╔═╡ 0d4b1a9b-de84-4e60-8256-ab48dbde4ccc
aside((md"![](https://github.com/Ricardo-Luis/me-2/blob/d32997eec06d150a8f0bf275d8c2d46f6fe6a732/images/MaqDCinduzido/commutator.jpg?raw=true)\

Fig. 5: Coletor e escovas, [^Kral_2022]


"),v_offset=110)

# ╔═╡ 689c4341-3ff8-4a3f-b913-8b196fde0a0f
md"""
## 1.4 - Comutação
"""

# ╔═╡ 8939ec96-c166-45cf-8e2d-3e5206428a00
md"""
A comutação é um processo fundamental nas máquinas CC e ocorre no processo de retificação mecânica da forma de onda da tensão induzida nas secções do enrolamento induzido (rotor) em movimento. Este processo é realizado pelo conjunto coletor e escovas, Fig. 5, que também retifica a corrente que circula no enrolamento. A comutação é essencial para manter a unidirecionalidade da corrente no exterior da máquina, característica que define uma máquina de corrente contínua.
"""

# ╔═╡ fabb1f60-abcb-4c49-b7bb-45308314aa7f
md"""
A Fig. 6, apresenta o processo de comutação numa secção do induzido em movimento. Assim, o início da comutação para a secção situada entre as lâminas do coletor 2 e 3 ocorre quando a lâmina se encontra sob a lâmina 2, Fig. 6(a).

Para a secção do induzido considerada, a comutação ocorre durante o tempo que as lâminas 2 e 3 estão curto-circuitadas pela escova. Neste processo, a superfície de contacto entre a escova e a lâmina 2 vai diminuindo, enquanto a superfície com a lâmina 3 vai aumentando, Fig. 6(b). A resistência variável das superfícies de contacto escova-lâminas, o coeficiente de autoindução da secção em comutação e a sua força eletromotriz induzida contribuem para a corrente em comutação, $i_c(t)$. A comutação termina quando a lâmina 3 se encontra totalmente sob escova, iniciando-se o processo de comutação para a secção colocada entre as lâminas 3 e 4, Fig. 6(c). Repare-se que o sentido da corrente na secção entre as lâminas 2 e 3 se inverte, entre o início e o final da comutação. 
"""

# ╔═╡ 6d0eff0a-8b0b-46d5-a42c-45cc8c5be27f
let
# raw_url -> on github draw.io file click the "Raw" button (top right, of file view) and then copy the URL from your browser address bar:	
   raw_url = "https://raw.githubusercontent.com/Ricardo-Luis/me-2/refs/heads/main/draw/MaqDCinduzido/DC.commutator.drawio"
   
# Adjustable settings:
   iframe_width = 790
   iframe_height = 300
# 1 = fit diagram to iframe size (keeps aspect ratio); 0 = original diagram size
   fit = 0  

# viewer_url build   
   viewer_url = "https://viewer.diagrams.net/?highlight=0000ff&edit=_blank&layers=1&nav=1&fit=$(fit)#U" * raw_url

# HTML
   HTML("""
   <div style="text-align: center;">
       <iframe frameborder="0" 
               style="width:$(iframe_width)px; height:$(iframe_height)px; border: 1px solid #ddd;" 
               src="$(viewer_url)">
       </iframe>
   </div>
   """)
end

# ╔═╡ bfbef154-1bcc-414c-858b-752718d60be9
md"""
Fig. 6: Processo de comutação para a secção ligada entre as lâminas 2 e 3: (a) início da comutação; (b) corrente em comutação; (c) fim da comutação / início da comutação para a secção seguinte. 
"""

# ╔═╡ 2e65b2fa-bd4d-4ec9-a326-41d52628e1a2


# ╔═╡ a801eae4-2280-4009-b16f-4133bf323ef8
md"""
### 1.4.1 - Curvas de comutação e causas de centelhamento
"""

# ╔═╡ 44cfe7bb-1a94-4923-9658-dc83704113c2
md"""
A trajetória da corrente de comutação, $i_c(t)$ depende de uma adequada escolha das escovas em conjunção com os parâmetros mencionados que interferem na corrente durante a comutação (superfícies de contacto escova-lâminas, coeficiente de autoindução e força eletromotriz da secção). Assim, $i_c(t)$ pode assumir diversas trajetórias, Fig.7:


"""

# ╔═╡ 1ebae2f5-045d-4b66-ba89-9ba398697233
let
# raw_url -> on github draw.io file click the "Raw" button (top right, of file view) and then copy the URL from your browser address bar:	
   raw_url = "https://raw.githubusercontent.com/Ricardo-Luis/me-2/refs/heads/main/draw/MaqDCinduzido/DC.commutation.drawio"
   
# Adjustable settings:
   iframe_width = 690
   iframe_height = 500
# 1 = fit diagram to iframe size (keeps aspect ratio); 0 = original diagram size
   fit = 0  

# viewer_url build   
   viewer_url = "https://viewer.diagrams.net/?highlight=0000ff&edit=_blank&layers=1&nav=1&fit=$(fit)#U" * raw_url

# HTML
   HTML("""
   <div style="text-align: center;">
       <iframe frameborder="0" 
               style="width:$(iframe_width)px; height:$(iframe_height)px; border: 1px solid #ddd;" 
               src="$(viewer_url)">
       </iframe>
   </div>
   """)
end

# ╔═╡ 22606757-ffca-4148-9a85-81a15c1a1c3a
md"""
Fig.7: Curvas de comutação. 
"""

# ╔═╡ 44a0c7c3-7671-4003-ab95-c1a2edc28365
md"""

Da Fig.7:
- **Trajetória** $\textbf{A}$: designada por **comutação linear ou resistiva**, onde a resistência de contacto entre lâminas e escovas é predominante durante o tempo de comutação, $T_c$. Trata-se de uma comutação aceitável, embora sejam visíveis algumas faíscas (centelhamento) entre o colector e as escovas;


- **Trajetória** $\textbf{B}$: apresenta uma **comutação ideal (ligeiramente adiantada)**, onde a corrente $i_c$ muda de sentido antes de $\dfrac{T_c}{2}$, terminando com uma tangente nula. Tal significa que a comutação termina com densidade de corrente nula, o que elimina a formação de faíscas;


- **Trajetória** $\textbf{C}$: **comutação retardada**, caracterizada po terminar com uma tangente $\alpha$ não nula. Trata-se de uma comutação inaceitavél, com elevada densidade de corrente no final do processo, resultando em faíscas das lâminas para as escovas (num tom esverdeado, devido à vaporização do cobre);


- **Trajetória** $\textbf{D}$: **comutação adiantada**, terminando também com uma tangente $\alpha$ não nula. Trata-se também de uma comutação inaceitavél, com uma densidade de corrente elevada no final da comutação, verificando-se faíscas da escova para a lâmina (num tom alaranjado, devido à vaporização do carvão).

No projeto de uma máquina CC procura-se que a curva de comutação se situe entre as trajetórias $\textbf{A}$ e $\textbf{B}$ como bom compromisso de funcionamento. 
"""

# ╔═╡ 3da3ba0f-4f0e-4843-83d7-7eccbec1073a


# ╔═╡ 17402250-5f39-4343-9dcb-a30a0d5a361f
md"""
O posicionamento das escovas é fundamental para o correto funcionamento da máquina CC. Idealmente, o plano das escovas deve estar em quadratura com a linha dos polos magnéticos ou de excitação. Essa posição é designada por **Linha Neutra Geométrica**  (linha de **N'** a **S'** da Fig. 4). Nessa posição, verifica-se que a força eletromotriz na(s) secção(ões) do induzido que entra(m) em comutação é nula, o que reduz a ocorrência de arcos elétricos (faíscas) entre as lâminas do coletor e as escovas. Um faiscamento intenso e prolongado no processo de comutação pode provocar, a longo prazo, dois tipos de deterioração na superfície do coletor:

- **Corrosão por picadas (_pitting_)**: surgimento de pequenas cavidades na superfície das lâminas do coletor por remoção de material (vaporização do cobre);

- **Sulcos de desgaste**: formação de ranhuras ou sulcos de desgaste, correspondente a rebaixamentos na superfície das lâminas na área de contacto com as escovas (desgaste abrasivo e vaporização do carvão).

Uma comutação insatisfatória (ocorrência de arcos elétricos) pode ainda danificar as escovas por sobreaquecimento. Assim, a monitorização da qualidade da comutação é essencial para o bom funcionamento da máquina CC.
"""

# ╔═╡ 5036db21-84b4-4912-9c29-6654ee919b1b
md"""
> **Nota:**
> Embora o estudo das curvas de comutação da Fig.7 não faça parte do programa da unidade curricular, a compreensão das suas implicações é importante para prevenir falhas e adequar os procedimentos de manutenção do coletor, conforme apresentado de seguida.
"""

# ╔═╡ a126d450-f7d9-48d6-abe7-951dba3da6f5
aside((md"
!!! cortesia
	As imagens relativas ao controlo de qualidade e perfilometria do coletor (Fig. 	8) foram gentilmente cedidas pela [**Fletcher Moorland Ltd.**](https://fletchermoorland.co.uk), empresa sediada em Stoke-on-Trent (Inglaterra) e especialista na reparação e revisão de máquinas elétricas. 
    
    Este contributo permite ilustrar com rigor o processo de validação técnica após 
	a intervenção de manutenção. 
	   
	Um agradecimento especial a **Matt Fletcher**, Diretor-Geral, pela disponibilidade e autorização de utilização.

"),v_offset=675)

# ╔═╡ 9042cd40-4d59-41c4-8515-ae5129c346c2
md"""
### 1.4.2 - Manutenção, retificação e diagnóstico do coletor
"""

# ╔═╡ 11fe3a35-1b56-42f0-9b1b-f9f7300a6a43
md"""
Para assegurar a longevidade e a eficiência da máquina CC, é essencial realizar a manutenção periódica do coletor. O processo de retificação do coletor (**_skimming_**) elimina as irregularidades, como sulcos e cavidades, bem como a ovalização da superfície de cobre decorrente do desgaste eletromecânico. Esta intervenção é realizada num torno de precisão para garantir uma superfície concêntrica e lisa. Desta forma, otimiza-se o contacto elétrico e previne-se o sobreaquecimento do induzido.

Conforme ilustrado na Fig. 8, a precisão da intervenção é validada através de metrologia digital. Um sensor de alta sensibilidade mapeia a superfície do coletor para garantir que o batimento radial (ou excentricidade) cumpre as tolerâncias exigidas.

Este rigor permite a formação da pátina ideal, uma película protetora de óxido de cobre e carbono que reduz o atrito e assegura uma comutação estável. A uniformidade desta constitui o principal indicador da condição operacional da máquina [^commutator_MAM]. 

Complementarmente, a análise da superfície de contacto das escovas [^brushes_MAM] permite validar a qualidade do contacto mecânico, maximizando a fiabilidade global da máquina de CC.
"""

# ╔═╡ 5869a88c-3855-4af1-8b56-225059ad636e
HTML("""
<div style="overflow-x: auto; width: 100%; padding: 15px; background: #fafafa; border: 1px solid #ddd; border-radius: 8px;">
	<div style="display: flex; flex-direction: row; width: max-content; gap: 10px; align-items: flex-start;">
		
		<div style="flex-shrink: 0; text-align: center; width: auto;">
			<img src="https://raw.githubusercontent.com/Ricardo-Luis/me-2/refs/heads/main/images/MaqDCinduzido/skimming.jfif" 
				 style="height: 800px; width: auto; max-width: none; display: block; border-radius: 4px; box-shadow: 2px 2px 10px rgba(0,0,0,0.1); margin: 0 auto;">
			<p style="margin-top: 10px; text-align: center;"><strong>(a)</strong></p>
		</div>

		<div style="flex-shrink: 0; text-align: center; width: auto;">
			<img src="https://raw.githubusercontent.com/Ricardo-Luis/me-2/refs/heads/main/images/MaqDCinduzido/skimming_detail.jfif" 
				 style="height: 800px; width: auto; max-width: none; display: block; border-radius: 4px; box-shadow: 2px 2px 10px rgba(0,0,0,0.1); margin: 0 auto;">
			<p style="margin-top: 10px; text-align: center;"><strong>(b)</strong></p>
		</div>

		<div style="flex-shrink: 0; text-align: center; width: auto;">
			<img src="https://raw.githubusercontent.com/Ricardo-Luis/me-2/refs/heads/main/images/MaqDCinduzido/profilometry.jfif" 
				 style="height: 800px; width: auto; max-width: none; display: block; border-radius: 4px; box-shadow: 2px 2px 10px rgba(0,0,0,0.1); margin: 0 auto;">
			<p style="margin-top: 10px; text-align: center;"><strong>(c)</strong></p>
		</div>

	</div>
</div>
""")


# ╔═╡ 21ba5da7-7644-49f8-86ca-394cd75a0335
md"""
Fig.8: Controlo de qualidade e perfilometria do coletor, [^Fletcher_Moorland].

 $\qquad\textbf{(a)}$ Monitorização digital da concentricidade e do batimento lâmina a lâmina, num torno de precisão;

 $\qquad\textbf{(b)}$ Detalhe do sensor de alta precisão em contacto com as lâminas do coletor; 

 $\qquad\textbf{(c)}$ Relatório final de perfilometria radial, validando a intervenção com um batimento total de $6$ µm.

"""

# ╔═╡ e70bc648-697a-4454-a9a9-6fc0173ce974


# ╔═╡ fe8c05b9-e4fe-4f43-91a4-90c150992a83


# ╔═╡ 4f237e49-6ff8-4539-a73d-8847d14d4696
md"""
# 2A - Procedimento de ensaio (Enrolamentos do induzido)
"""

# ╔═╡ d51cf305-b047-4f54-8875-c161edc12cd1
md"""
## 2A.1 - 💻 Dados da máquina de corrente contínua (modelo)
"""

# ╔═╡ 8cc2adb9-6748-4859-92cc-f9014c42392e
md"""
Introduzir os dados do modelo de madeira representativo de um rotor de uma máquina CC:
"""

# ╔═╡ 2c807192-20d8-4bbd-9d6e-496f592b404a
md"""
 $$\textrm{modelo n.º:}$$  $(@bind modelo TextField(default=""))


 $$k =$$ $(@bind k NumberField(0:100, default=24)) cavas


 $$c =$$ $(@bind c NumberField(0:200, default=48)) lâminas


 $$p =$$  $(@bind p NumberField(0:10, default=2)) pares de polos

"""

# ╔═╡ b8ce899e-dc76-4b98-b563-703f6fb296d7
aside((md"""
!!! info "Informação"
	A biblioteca `handcalcs.jl` permite transpor código de cálculo em Julia para $\LaTeX$, apresentando a fórmula simbólica, a substituição automática das grandezas pelos seus valores numéricos e o resultado final da expressão.\
	Como a `handcalcs.jl` expõe estas substituições numéricas, os cálculos tornam-se significativamente mais fáceis de verificar.
"""), v_offset=100)

# ╔═╡ 5bd6c690-c2e9-4353-b262-fafb845a0aec
md"""
## 2A.2 - Dimensionamento: enrolamento imbricado simples
"""

# ╔═╡ 2923d3f5-c427-44a9-9b7e-8e34458b4fb4
@handcalcs begin	
	s = c
	yₚ = (2*s) / (2*p)
end

# ╔═╡ 9f176d1f-39e4-4e4a-83dd-09751c92b91a


# ╔═╡ 0476d46a-b9d3-4f52-a461-5f997df6696d
md"""
O enrolamento com coletor tem de fechar sobre si. No caso do enrolamento imbricado simples, o enrolamento fecha sempre desde que o passo resultante, $y$, tome os valores: 

$\begin{align}
y&=+2\quad\quad  \Rightarrow \quad\quad \text{imbricado simples do tipo progressivo}\\
y&=-2\quad\quad  \Rightarrow \quad\quad \enclose{horizontalstrike}{\text{imbricado simples do tipo retrógrado ou cruzado}}
\end{align}$

Na prática, na realização do enrolamento induzido, apenas a solução do tipo progressivo é utilizada, pois as ligações das secções às lâminas do coletor vão avançando progressivamente, utilizando assim menos cobre, tornando esta opção mais económica. 
"""

# ╔═╡ d90c4748-0ae2-4c2b-b795-face64b7e4d6
md"""
Assim:
"""

# ╔═╡ e24f3b48-56c4-4869-bc53-64af098f6182
md"""
$y=2=y_1+y_2$
"""

# ╔═╡ 873c12b0-8115-4fc4-998d-07ba25883df6
md"""
Considerando valores de passo posterior $$y_1$$, próximos do passo polar, $$y_p$$ e  número ímpar:

$$y_1 \approx y_p$$
"""

# ╔═╡ b2cd7ec8-5ee9-4523-8e84-7ad92f9a76c3
if isodd(yₚ) 					# Is this an odd number?
	@handcalcs begin 			# if true (odd number)
		y₁=[yₚ yₚ+2 yₚ-2] 		#adjust the sum and difference to get odd number (integer)
		y₂=2 .- y₁
	end
else 							# if false (even number)
	@handcalcs begin
		y₁=[yₚ+1 yₚ+3 yₚ-1] 	#adjust the sum and difference to get odd number (integer)
		y₂=2 .- y₁
	end
end

# ╔═╡ 5131e8fb-3de1-4c1b-9a8c-a35e2e352ad2


# ╔═╡ f5cf82e8-1aaa-452b-85da-28503108c97b
md"""
Das possibilidades encontradas testa-se o par de valores de $(y_1, y_2)$ mais próximo de $y_p$.\
No entanto, não é prático a colocação das secções nas cavas do induzido, contando os lados ativos correspondentes a $(y_1, y_2)$. \
Na prática, torna-se mais conveniente transpor a contagem em lados ativos para uma contagem em número de cavas.\
Assim, definem-se os parâmetros:\
\
 $\qquad u$: Número de lados ativos por cava;\
 $\qquad y_{1k}$: Passo da secção ou passo posterior em número de cavas;\
 $\qquad y_{2k}$: Passo da ligação ou passo anterior em número de cavas.
"""

# ╔═╡ 169cd52b-44ef-46c1-a9c9-a36e14f0c44c


# ╔═╡ 1ebad95b-da33-4c73-9091-72419ab236f6
md"""
Transpondo as soluções de  $\:y_1,\: y_2\:$, para $\:y_{1k}, \:y_{2k}\:$, tém-se:
"""

# ╔═╡ 0ffc2616-077b-4fc2-bc17-c987f6f470de
@handcalcs begin
	la = 2s 
	u = la / k
	y₁ₖ = (y₁ .- 1) / u
	y₂ₖ = (y₂ .+ 1) / u
end

# ╔═╡ 2b7e69e3-270e-488d-a120-5b2029ce48b7
md"""
Considerando as soluções encontradas, a opção para realização do enrolamento imbricado deve recair num passo de secção, medido em número de cavas, $y_{1k}$, que seja um número inteiro. Tal é importante, porque significa que o enrolamento induzido será constituído por secções (bobinas) iguais em dimensão.
"""

# ╔═╡ 0b8f9c31-f74d-4021-9b13-1b565da3918e
md"""
**Cálculos auxiliares para extrair os passos inteiros:**
"""

# ╔═╡ b7e964ea-ed6e-42cd-a9ce-6ee1f12caedb
begin
	c_int1=isinteger.(y₁ₖ)
	x=findfirst(isequal(1), c_int1)
	index=getindex(x, 2)	
	c_int1, x, index
end;

# ╔═╡ af20c2ea-26f0-4def-aa47-c09d255cece8
begin
	y₁ₖ_sol = y₁ₖ[index]
	y₂ₖ_sol = round(y₂ₖ[index], digits=3)
	y₁ₖ_sol, y₂ₖ_sol
end

# ╔═╡ 9fb13e92-41bc-4948-8e5e-7db1e0fd4571


# ╔═╡ b432b0a5-1333-46c7-b616-657dcc5c9bb7
md"""
### **Solução: Imbricado simples**
"""

# ╔═╡ 84d93def-10b6-4108-9b32-9ae6199f3c06
md"""
Verifica-se que para realizar o enrolamento induzido do tipo **imbricado simples** no modelo de rotor n.º $(modelo), são necessários os seguintes passos, em número de cavas:

| melhores passos | número de cavas |
|:---:|:---:|
| $$y_{1k}$$ | $(y₁ₖ_sol[1]) |
| $$y_{2k}$$ | $(y₂ₖ_sol[1]) |
| | |
"""

# ╔═╡ a832f08b-cb3d-4b5f-9d6e-e0843aabbbaa


# ╔═╡ 069d947f-261b-4ac6-a679-345d5e3d4879
md"""
## 2A.3 - Dimensionamento: enrolamento ondulado simples
"""

# ╔═╡ 04ae7282-aaef-44b3-928c-105b905b39b1
md"""
Considerando o mesmo modelo de rotor em madeira, para a execução do enrolamento ondulado, **é necessário garantir um passo de coletor, $y_c$, que seja um número inteiro**, garantindo assim que o enrolamento ondulado se feche sobre si.

O passo de coletor, $y_c$ para um enrolamento ondulado simples é obtido:

$\begin{align}
y_c&=\frac{s-1}{p}\quad\quad  \Rightarrow \quad\quad \text{ondulado simples do tipo retrógrado (1ª opção)}\\
y_c&=\frac{s+1}{p}\quad\quad  \Rightarrow \quad\quad \text{ondulado simples do tipo progressivo ou cruzado (2ª opção)}
\end{align}$
"""

# ╔═╡ 413f497a-8917-448c-923d-f89938bb75ea
md"""
Calculando os valores para o passo de coletor, $y_c$, tém-se:
"""

# ╔═╡ 7919291c-85f2-43b1-8a6a-486d98a1f8ca
@handcalcs begin	
	yc = [(s-1)/p ; (s+1)/p]
end

# ╔═╡ 01e85628-c172-45ff-a959-447fb536a046
begin 
	x1=findfirst(isinteger.(yc))
	if x1==1
		sᴹ = 0
		md"""**Enrolamento ondulado simples do tipo retrógrado**, com: $$\quad y_c=$$ $(yc[1]) lâminas"""
	elseif x1==2
		sᴹ = 0
		md"""**Enrolamento ondulado simples do tipo cruzado**, com: $$\quad y_c=$$ $(yc[2]) lâminas"""
	else
		md"""O enrolamento do induzido do tipo ondulado **não fecha**!\
		Definir quantidade de **secções mortas**, $\: sᴹ=$ $(@bind sᴹ Slider(1:4, default=1, show_value=true))"""
	end
end

# ╔═╡ b2681f86-0941-460b-9364-83e84d96e771


# ╔═╡ c332fd77-2c8d-407b-9b26-61ed97bb7d02
md"""
Caso o enrolamento não feche é necessário considerar 1 ou mais "secções mortas" (secções que são colocadas nas cavas, mas não são ligadas eletricamente) e repetir o cálculo de $y_c$: 
"""

# ╔═╡ 8fc1994c-9dc7-48aa-aaa6-0d30accf77c0
@handcalcs begin	
	sᴹ
	sₑₗ = s - sᴹ
	ycᴹ = [(sₑₗ-1)/p ; (sₑₗ+1)/p]
end

# ╔═╡ f7676f1c-afe7-4b0a-bd1b-95253749444c
md"""
Definem-se os passos de secção, $y_1$, e de ligação, $y_2$, em número ímpar e de modo que a transposição destes passos para número de cavas, permita obter no $y_{1k}$ um número inteiro, ou seja, significando tamanho das secções iguais.
""" 

# ╔═╡ db42fc9a-128a-4cce-bf2e-d4aff43d52aa
md"""
Como $y_c=y$ em número de lados ativos e como $c=\dfrac{la}{2}$, tém-se $y_c=\dfrac{y}{2}$ em número de lâminas.
"""

# ╔═╡ 3b315cdc-0e3c-4201-9f48-0ddebdd56f22
begin 
	i=findfirst(isinteger.(ycᴹ))

	if isodd(ycᴹ[i]) 
		@handcalcs begin
			i
			Y₁ = ycᴹ[i]+0 			# adjust the subtraction until get Y1k integer
			Y₂ = ycᴹ[i]*2 - Y₁
		end
	elseif iseven(ycᴹ[i]) 
		@handcalcs begin
			i
			Y₁ = ycᴹ[i]-1 			# adjust the subtraction until get Y1k integer
			Y₂ = ycᴹ[i]*2 - Y₁
		end
	end
end

# ╔═╡ 359a134c-f8cc-4308-8a18-ed0d1392ea9f
md"""
Transpondo as soluções de  $\:Y_1,\: Y_2\:$, para $\:Y_{1k}, \:Y_{2k}\:$, tém-se:
"""

# ╔═╡ 8b226a7b-bc4b-4197-93fc-99d16946b71e
@handcalcs begin
	Y₁ₖ = (Y₁ - 1) / u
	Y₂ₖ = (Y₂ + 1) / u
end

# ╔═╡ 827e892e-1630-44ce-b25c-42c280d97816
if isinteger.(Y₁ₖ)==true
	md" $y_{1k}$ é número inteiro. **Cálculo concluído!**"
else
	md" $y_{1k}$ não é número inteiro. **Ajustar $y_1$!**"
end

# ╔═╡ 422f584a-0775-4514-8356-8425475fea74


# ╔═╡ b1dcbdaf-0d8f-4b2a-bc21-06b1c5541c1a
md"""
### **Solução: Ondulado simples**
"""

# ╔═╡ 8d8f8e8d-3ecd-4f30-8a9c-0b6a82dc85c9
md"""
Verifica-se que para realizar o enrolamento induzido do tipo **ondulado simples** no modelo de rotor n.º $(modelo), são necessários os seguintes passos, em número de cavas:

| melhores passos | número de cavas |
|:---:|:---:|
| $$y_{1k}$$ | $(Y₁ₖ) |
| $$y_{2k}$$ | $(Y₂ₖ) |
| $$y_{c}$$ | $(ycᴹ[i]) |
| | |
"""

# ╔═╡ 73035108-ce5a-4bca-8fb3-6e6c097ea4e0


# ╔═╡ ef757caa-cc6f-4934-be18-bcb292c92fc9
md"""
# 2B - Procedimento de ensaio (Reação magnética do induzido e comutação)
"""

# ╔═╡ 2140af27-202a-40e4-800e-f5d08c9ccfca
md"""
## 2B.1 - Esquema de ligações

(📌 Secção a completar em aula com as suas observações)
\
\
\
\
\
\
\
\
\
\
\
\
\
\
\
\
\
\
"""

# ╔═╡ f79caae4-82b6-4917-b3b4-fc180d2f188f


# ╔═╡ b5ded038-cd25-4da6-8429-0c162dae4477
md"""
## 2B.2 - Material utilizado

(📌 Secção a completar em aula com as suas observações)

\
\
\
\
\
\
\
\
\
\
\
\
\
"""

# ╔═╡ 3c04f72e-06be-4ed1-b0d8-ce32b8723b29


# ╔═╡ f3beefea-a678-4e9c-8dcd-2059767a97c4
md"""
## 2B.3 - Condução do trabalho
"""

# ╔═╡ 5cd1e0c4-2eec-4470-bcf1-21298b29fb6d
md"""
1. Ligar a rede de corrente contínua do lab. e proceder à manobra de arranque do motor CC;\
1. Ligar o circuito de excitação do gerador CC;
No gerador:
3. Observar o valor da força eletromotriz induzida, para diferentes posições do plano das escovas;
1. Retirar o valor da Linha Neutra Geométrica ou Linha Neutra Magnética em vazio;
1. Ligar o circuito de carga no valor máximo de corrente;
1. Observar o valor da força eletromotriz induzida para diferentes posições do plano das escovas;
1. Observar o faiscamento no processo de comutação;
1. Procurar a Linha Neutra Magnética em carga;
1. Desligar as máquinas por ordem inversa;
1. Fim do ensaio.

"""

# ╔═╡ 312645a8-7098-474d-b3b3-1499b96606d8


# ╔═╡ 12519278-2cd1-42a3-8b24-eae19910649a
md"""
# 3 - Resultados experimentais
"""

# ╔═╡ 7412c059-dd62-4c77-919f-be095b5664f2
md"""
## 3.1 - Observações sobre enrolamentos do induzido
"""

# ╔═╡ 16933177-1655-4d68-b2be-6a2d26d02280
md"""
(📌 Secção a completar em aula com as suas observações)

- **Enrolamento imbricado:**
\
\
\
\
\
\
\

- **Enrolamento ondulado:**
\
\
\
\
\
\
\
"""

# ╔═╡ feda8823-b422-43f2-969b-c4becc9c3cb7


# ╔═╡ 37256831-071a-4f90-937d-c9bad69ad643
md"""
## 3.2 - Observações sobre: reação magnética do induzido e comutação
"""

# ╔═╡ ab9cc707-2ce2-4eb2-987f-c27755dd9d85
md"""
(📌 Secção a completar em aula com as suas observações)

- **Linha Neutra Geométrica (LNG) ou Linha Neutra Magnética (LNM) em vazio:**
\
Ângulo LNG = _____°
\
\
\
\
\

- **Linha Neutra Magnética em carga ou Linha Neutra Real:**
\
Ângulo de calagem das escovas = _____°
\
\
\
\
\
\

- **Comutação:**
\
\
\
\
\
\
\
"""

# ╔═╡ a9de66ab-deab-4e4c-a5f9-a672805a24a4


# ╔═╡ c003b9a6-7d8b-4b49-ad41-1661618522b4
md"""
# 4 - Conclusões
(📌 Secção a completar em aula com as suas observações)
\
\
\
\
\
\
\
\
\
\
\
\
\
\
\
"""

# ╔═╡ 06ae56ec-52d0-46d1-96da-3613ecc56df2
md"""
# Bibliografia

[^commutator_MAM]: Morgan Advanced Materials, [*"Commutator Patina - Technical Guide"*](https://www.morganperformancecarbon.com/media/cusotjtf/commutator_patina.pdf), Morgan Carbon Technical Publications.

[^brushes_MAM]: Morgan Advanced Materials, [*"Surface Appearance of Brushes - Diagnostic Guide"*](https://www.morganperformancecarbon.com/media/2dhojel0/surface_appearance_of_brushesa.pdf), Morgan Carbon Technical Publications.


## Créditos das imagens

[^Kennedy_1903]: Rankin Kennedy, Electrical Installations, vol. III, London: Caxton, 1903. 

[^Audel_1917]: Theo. Audel & Co., Hawkins Electrical Guide, Volume 1, Chapter 20: Commutation and the Commutator, Page 286, USA, 1917.

[^Kral_2022]:  Christian Kral, [Commutator and brushes DC motor](https://commons.wikimedia.org/w/index.php?curid=122251615), Own work, CC BY 4.0, 2022. 

[^Fletcher_Moorland]: Fletcher Moorland Ltd., *"Commutator Skimming and Profilometry Analysis"*, [fletchermoorland.co.uk](https://fletchermoorland.co.uk/comm-skim-undercut/).


## Sugestões de leitura:

- José Carvalho (2018). Máquinas Elétricas de Corrente Contínua: Reação Magnética do Induzido e Comutação. Revista técnico-científica “Neutro-à-Terra”, ISEP\Departamento de Engenharia Eletrotécnica. DOI: [https://doi.org/10.34630/neutroaterra.vi21.4393](https://doi.org/10.34630/neutroaterra.vi21.4393)


- [C. Pereira Cabrita, "Escovas de Carvão para Máquinas Eléctricas: características técnicas e manutenção", Fundação EDP-Museu da Electricidade, revista Electricidade, n.º 383, pp. 299-312, Dez. 2000.](https://www.gest.colecoesfundacaoedp.edp.pt/Nyron/Library/Catalog/winlibimg.aspx?skey=CE7FA17DDB0743DB9CD1BDFF0CDDD76C&doc=167812&img=159270)


"""

# ╔═╡ bc2a479e-a961-43ef-b430-afd69b496ac0
begin
	#=
	Advanced CSS code for text formatting in Pluto.jl notebooks
	- Applies text justification and automatic hyphenation to content
	- Bilingual support: European Portuguese (pt-PT) and English (en)
	- Dynamic mapping based on the 'lang' selector variable
	- Uses system fonts with fallbacks for better compatibility
	- Significantly improves readability of long texts
	
	Developed with GenAI assistance from Claude (Anthropic) - September 2025
	=#
	
	# Language code mapping for specific locales
	#lang_code = lang == "pt" ? "pt-PT" : lang
	lang_code = "pt-PT"
	
	html"""<div lang="$(lang_code)">
	<style>
	pluto-output p {
	   text-align: justify;
	   hyphens: auto;
	   -webkit-hyphens: auto;
	   -ms-hyphens: auto;
	   -moz-hyphens: auto;
	}
	pluto-output {
	   font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
	   font-size: 100%;
	}
	</style>
	</div>
	"""
end

# ╔═╡ b467ed22-2892-4875-a2b7-173efafa5a8d
md"""
# *Notebook*
"""

# ╔═╡ 68fff8eb-4988-4c68-a543-2ddef8e4c428
md"""
Documentação das bibliotecas Julia utilizadas: [PlutoUI](https://featured.plutojl.org/basic/plutoui.jl), [PlutoTeachingTools](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html), [Handcalcs](https://co1emi11er2.github.io/Handcalcs.jl/stable/).
"""

# ╔═╡ 8ce3ded3-faa0-423a-9ce2-582d242f4dc8
begin
	version=VERSION
	md"""
	*Notebook* desenvolvido em `Julia` versão $(version).
	"""
end

# ╔═╡ 0cc7f332-f41a-4822-bcad-f06ee56d110f
TableOfContents(title="Índice")

# ╔═╡ a916e2c4-ef39-4bd0-8c96-732ae356a8b1
aside((md"""
!!! info "Informação"
	No índice deste *notebook*, o tópico assinalado com "💻" requer a participação do estudante.
"""), v_offset=-100)

# ╔═╡ bb928631-6cf1-4f9a-ac8b-1fa072d19f69
md"""
|  |  |
|:--:|:--|
|  | This notebook, [MaqDCinduzido.jl](https://ricardo-luis.github.io/me-2/MaqDCinduzido.html), is part of the collection "[_Notebooks_ Computacionais Aplicados a Máquinas Elétricas II](https://ricardo-luis.github.io/me-2/)" by Ricardo Luís. |
| **Terms of Use** | All narrative and visual content is shared under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)), while the Julia code snippets are released under the [MIT License](https://www.tldrlegal.com/license/mit-license).|
|  | $©$ 2022-2026 [Ricardo Luís](https://ricardo-luis.github.io) |
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Handcalcs = "e8a07092-c156-4455-ab8e-ed8bc81edefb"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Handcalcs = "~0.4.4"
PlutoTeachingTools = "~0.4.6"
PlutoUI = "~0.7.77"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.6"
manifest_format = "2.0"
project_hash = "57a4c468bd84e35aa789b065be5fef476434a0a3"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.AbstractTrees]]
git-tree-sha1 = "2d9c9a55f9c93e8887ad391fbae72f8ef55e1177"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.5"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "062c5e1a5bf6ada13db96a4ae4749a4c2234f521"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.3.9"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.Compiler]]
git-tree-sha1 = "382d79bfe72a406294faca39ef0c3cef6e6ce1f1"
uuid = "807dbc54-b67e-4c79-8afb-eafe4df6f2e1"
version = "0.1.1"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.3.0+1"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.7.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Zlib_jll"]
git-tree-sha1 = "38044a04637976140074d0b0621c1edf0eb531fd"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.1+0"

[[deps.Handcalcs]]
deps = ["AbstractTrees", "CodeTracking", "InteractiveUtils", "LaTeXStrings", "Latexify", "MacroTools", "PrecompileTools", "Revise", "TestHandcalcFunctions"]
git-tree-sha1 = "7f27904769778c2e476a6da73a9021e6589c9d21"
uuid = "e8a07092-c156-4455-ab8e-ed8bc81edefb"
version = "0.4.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "0ee181ec08df7d7c911901ea38baf16f755114dc"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "1.0.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "0533e564aae234aff59ab625543145446d8b6ec2"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.1"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6893345fd6658c8e475d40155789f4860ac3b21"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.1.4+0"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "6ac9e4acc417a5b534ace12690bc6973c25b862f"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.10.3"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.Latexify]]
deps = ["Format", "Ghostscript_jll", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "44f93c47f9cd6c7e431f2f2091fcba8f01cd7e8f"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.10"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"
    TectonicExt = "tectonic_jll"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"
    tectonic_jll = "d7dd28d6-a5e6-559c-9131-7eb760cdacc5"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.15.0+0"

[[deps.LibGit2]]
deps = ["LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.9.0+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "OpenSSL_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.3+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.12.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.LoweredCodeUtils]]
deps = ["Compiler", "JuliaInterpreter"]
git-tree-sha1 = "b882a7dd7ef37643066ae8f9380beea8fdd89cae"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "3.4.2"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2025.11.4"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.29+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.4+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.12.1"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "Latexify", "Markdown", "PlutoUI"]
git-tree-sha1 = "dacc8be63916b078b592806acd13bb5e5137d7e9"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.4.6"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "6ed167db158c7c1031abf3bd67f8e689c8bdf2b7"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.77"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "07a921781cab75691315adc645096ed5e370cb77"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.3.3"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "522f093a29b31a93e34eaea17ba055d850edea28"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.REPL]]
deps = ["InteractiveUtils", "JuliaSyntaxHighlighting", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.Revise]]
deps = ["CodeTracking", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "f6f7d30fb0d61c64d0cfe56cf085a7c9e7d5bc80"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.8.0"

    [deps.Revise.extensions]
    DistributedExt = "Distributed"

    [deps.Revise.weakdeps]
    Distributed = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.TestHandcalcFunctions]]
git-tree-sha1 = "54dac4d0a0cd2fc20ceb72e0635ee3c74b24b840"
uuid = "6ba57fb7-81df-4b24-8e8e-a3885b6fcae7"
version = "0.2.4"

[[deps.Tricks]]
git-tree-sha1 = "311349fd1c93a31f783f977a71e8b062a57d4101"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.13"

[[deps.URIs]]
git-tree-sha1 = "bef26fb046d031353ef97a82e3fdb6afe7f21b1a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.6.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.3.1+2"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.15.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.64.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.7.0+0"
"""

# ╔═╡ Cell order:
# ╟─91180300-0b49-4211-9ad3-12fd0785f518
# ╟─4e3917b0-4458-11ef-2b69-bd55e90578e0
# ╟─bb397679-8965-4486-8c22-80a973b00bd1
# ╟─2239ebd6-bb9c-4e48-bf2b-78557cd8f7e6
# ╟─14c7e7d9-5e3f-4680-a625-cfa81ba48e69
# ╟─9ef12029-565b-4a7c-8075-da777a76159d
# ╟─dfa3294f-a708-4ce8-afcd-b75d02ade322
# ╟─951470b1-3506-4d92-898d-5b3f996e0bab
# ╟─09eb0bd2-d889-4969-a426-5d76b394dd4b
# ╟─f5802767-8a84-4a79-a949-2c873e47af28
# ╟─ff0e1c6b-6c1a-4d27-b986-a2c003b27ab3
# ╟─de94ef0e-5ff7-4233-b38b-ad6ad6ec8171
# ╟─b7a4e10d-c775-43a1-9dd5-172533d979ce
# ╟─1dac7191-d776-46dd-8178-dd1e7685533c
# ╟─1e7bf323-80aa-4d3e-92ac-fa45b5992d49
# ╟─9a85c027-b125-407e-ad2a-05ed3df3720a
# ╟─43e643d4-9a85-4b5a-ac50-629a25bef0d2
# ╟─a9ae848a-2d79-44f9-8a46-9371b916004d
# ╟─e1245c3a-cd1e-416f-ac23-e612b8be5157
# ╟─7c117066-973e-466d-92aa-f507e69affd6
# ╟─63820b95-7bf3-40a0-b758-b8eefe194ff0
# ╟─e74e74fd-0c8b-445b-aaa5-9df365b8c589
# ╟─1e6969b2-da36-4cbb-a7a8-47468716c86b
# ╟─904019a5-542f-4a77-9db2-979caa67d261
# ╟─7b102a0a-c257-47d5-aabc-a267af9bd5a5
# ╟─dd4ece32-e186-46ea-a1fc-a31dc8f80388
# ╟─eaef98e4-c79f-4932-8b7c-32a90fa664db
# ╟─3571ba78-44b7-489a-a2bd-c4841c931879
# ╟─2b9ef51e-bfe4-4a77-9e04-f1eea7320f99
# ╟─0d4b1a9b-de84-4e60-8256-ab48dbde4ccc
# ╟─689c4341-3ff8-4a3f-b913-8b196fde0a0f
# ╟─8939ec96-c166-45cf-8e2d-3e5206428a00
# ╟─fabb1f60-abcb-4c49-b7bb-45308314aa7f
# ╟─6d0eff0a-8b0b-46d5-a42c-45cc8c5be27f
# ╟─bfbef154-1bcc-414c-858b-752718d60be9
# ╟─2e65b2fa-bd4d-4ec9-a326-41d52628e1a2
# ╟─a801eae4-2280-4009-b16f-4133bf323ef8
# ╟─44cfe7bb-1a94-4923-9658-dc83704113c2
# ╟─1ebae2f5-045d-4b66-ba89-9ba398697233
# ╟─22606757-ffca-4148-9a85-81a15c1a1c3a
# ╟─44a0c7c3-7671-4003-ab95-c1a2edc28365
# ╟─3da3ba0f-4f0e-4843-83d7-7eccbec1073a
# ╟─17402250-5f39-4343-9dcb-a30a0d5a361f
# ╟─5036db21-84b4-4912-9c29-6654ee919b1b
# ╟─a126d450-f7d9-48d6-abe7-951dba3da6f5
# ╟─9042cd40-4d59-41c4-8515-ae5129c346c2
# ╟─11fe3a35-1b56-42f0-9b1b-f9f7300a6a43
# ╟─5869a88c-3855-4af1-8b56-225059ad636e
# ╟─21ba5da7-7644-49f8-86ca-394cd75a0335
# ╟─e70bc648-697a-4454-a9a9-6fc0173ce974
# ╟─fe8c05b9-e4fe-4f43-91a4-90c150992a83
# ╟─4f237e49-6ff8-4539-a73d-8847d14d4696
# ╟─d51cf305-b047-4f54-8875-c161edc12cd1
# ╟─8cc2adb9-6748-4859-92cc-f9014c42392e
# ╟─2c807192-20d8-4bbd-9d6e-496f592b404a
# ╟─b8ce899e-dc76-4b98-b563-703f6fb296d7
# ╟─5bd6c690-c2e9-4353-b262-fafb845a0aec
# ╠═2923d3f5-c427-44a9-9b7e-8e34458b4fb4
# ╟─9f176d1f-39e4-4e4a-83dd-09751c92b91a
# ╟─0476d46a-b9d3-4f52-a461-5f997df6696d
# ╟─d90c4748-0ae2-4c2b-b795-face64b7e4d6
# ╟─e24f3b48-56c4-4869-bc53-64af098f6182
# ╟─873c12b0-8115-4fc4-998d-07ba25883df6
# ╠═b2cd7ec8-5ee9-4523-8e84-7ad92f9a76c3
# ╟─5131e8fb-3de1-4c1b-9a8c-a35e2e352ad2
# ╟─f5cf82e8-1aaa-452b-85da-28503108c97b
# ╟─169cd52b-44ef-46c1-a9c9-a36e14f0c44c
# ╟─1ebad95b-da33-4c73-9091-72419ab236f6
# ╠═0ffc2616-077b-4fc2-bc17-c987f6f470de
# ╟─2b7e69e3-270e-488d-a120-5b2029ce48b7
# ╟─0b8f9c31-f74d-4021-9b13-1b565da3918e
# ╠═b7e964ea-ed6e-42cd-a9ce-6ee1f12caedb
# ╠═af20c2ea-26f0-4def-aa47-c09d255cece8
# ╟─9fb13e92-41bc-4948-8e5e-7db1e0fd4571
# ╟─b432b0a5-1333-46c7-b616-657dcc5c9bb7
# ╟─84d93def-10b6-4108-9b32-9ae6199f3c06
# ╟─a832f08b-cb3d-4b5f-9d6e-e0843aabbbaa
# ╟─069d947f-261b-4ac6-a679-345d5e3d4879
# ╟─04ae7282-aaef-44b3-928c-105b905b39b1
# ╟─413f497a-8917-448c-923d-f89938bb75ea
# ╠═7919291c-85f2-43b1-8a6a-486d98a1f8ca
# ╟─01e85628-c172-45ff-a959-447fb536a046
# ╟─b2681f86-0941-460b-9364-83e84d96e771
# ╟─c332fd77-2c8d-407b-9b26-61ed97bb7d02
# ╠═8fc1994c-9dc7-48aa-aaa6-0d30accf77c0
# ╟─f7676f1c-afe7-4b0a-bd1b-95253749444c
# ╟─db42fc9a-128a-4cce-bf2e-d4aff43d52aa
# ╠═3b315cdc-0e3c-4201-9f48-0ddebdd56f22
# ╟─359a134c-f8cc-4308-8a18-ed0d1392ea9f
# ╠═8b226a7b-bc4b-4197-93fc-99d16946b71e
# ╟─827e892e-1630-44ce-b25c-42c280d97816
# ╟─422f584a-0775-4514-8356-8425475fea74
# ╟─b1dcbdaf-0d8f-4b2a-bc21-06b1c5541c1a
# ╟─8d8f8e8d-3ecd-4f30-8a9c-0b6a82dc85c9
# ╟─73035108-ce5a-4bca-8fb3-6e6c097ea4e0
# ╟─ef757caa-cc6f-4934-be18-bcb292c92fc9
# ╟─2140af27-202a-40e4-800e-f5d08c9ccfca
# ╟─f79caae4-82b6-4917-b3b4-fc180d2f188f
# ╟─b5ded038-cd25-4da6-8429-0c162dae4477
# ╟─3c04f72e-06be-4ed1-b0d8-ce32b8723b29
# ╟─f3beefea-a678-4e9c-8dcd-2059767a97c4
# ╟─5cd1e0c4-2eec-4470-bcf1-21298b29fb6d
# ╟─312645a8-7098-474d-b3b3-1499b96606d8
# ╟─12519278-2cd1-42a3-8b24-eae19910649a
# ╟─7412c059-dd62-4c77-919f-be095b5664f2
# ╟─16933177-1655-4d68-b2be-6a2d26d02280
# ╟─feda8823-b422-43f2-969b-c4becc9c3cb7
# ╟─37256831-071a-4f90-937d-c9bad69ad643
# ╟─ab9cc707-2ce2-4eb2-987f-c27755dd9d85
# ╟─a9de66ab-deab-4e4c-a5f9-a672805a24a4
# ╟─c003b9a6-7d8b-4b49-ad41-1661618522b4
# ╟─06ae56ec-52d0-46d1-96da-3613ecc56df2
# ╟─bc2a479e-a961-43ef-b430-afd69b496ac0
# ╟─b467ed22-2892-4875-a2b7-173efafa5a8d
# ╟─68fff8eb-4988-4c68-a543-2ddef8e4c428
# ╠═3b461ddf-3b4b-457b-9f9c-f606d8b260aa
# ╟─8ce3ded3-faa0-423a-9ce2-582d242f4dc8
# ╠═0cc7f332-f41a-4822-bcad-f06ee56d110f
# ╟─a916e2c4-ef39-4bd0-8c96-732ae356a8b1
# ╟─bb928631-6cf1-4f9a-ac8b-1fa072d19f69
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
