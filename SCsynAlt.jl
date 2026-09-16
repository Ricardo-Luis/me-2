### A Pluto.jl notebook ###
# v1.0.3

#> [frontmatter]
#> tags = ["lecture", "module4"]
#> title = "Curto-circuito simétrico de um alternador"
#> description = "Analisa-se detalhadamente o curto-circuito simétrico 3~ num alternador síncrono em vazio, combinando os fundamentos teóricos com simulação numérica para observar o transitório das correntes de curto-circuito do alternador. Através de parâmetros ajustáveis, como o ângulo de falha (α), os estudantes podem observar como as correntes de curto-circuito (CA e CC) evoluem, compreendendo o papel das reatâncias síncronas e das constantes de tempo. Inclui-se ainda a modelação do transitório da corrente rotórica, enriquecendo a análise com exemplos numéricos e comparações com dados técnicos."
#> chapter = 3
#> section = 2
#> image = "https://github.com/Ricardo-Luis/me-2/blob/3b6078f37ee7f4cb3f36f456198e97773ec2c879/images/card/SCsynAlt.png?raw=true"
#> layout = "layout.jlhtml"
#> date = "2026-09-11"
#> order = 2
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

# ╔═╡ ccb548ca-265d-42fa-a64e-c6f0a29a17df
using PlutoUI, PlutoTeachingTools, Plots
#= 
Brief description of the used Julia packages:
  - PlutoUI.jl, to add interactivity objects
  - PlutoTeachingTools.jl, to enhance the notebook
  - Plots.jl, visualization interface and toolset to build graphics
=#

# ╔═╡ 0176f110-acf2-11ef-1aa9-eff867ac861f
TwoColumnWideLeft(md"`SCsynAlt.jl`", md"`Last update: 11·09·2026`")

# ╔═╡ c69f0608-04f7-4c40-aa9f-6a400d353d80
md"""
---
$\textbf{MÁQUINAS ELÉTRICAS SÍNCRONAS TRIFÁSICAS}$

$\colorbox{Bittersweet}{\textcolor{white}{\textbf{Curto-circuito simétrico de um alternador em vazio: análise do transitório}}}$
---
"""

# ╔═╡ 0ecffabc-9301-489e-b1a0-d0993ff4b404
md"""
Para o estudo do curto-circuito simétrico de um alternador em vazio foram utilizados os dados da máquina síncrona **G₁** da tabela 1 de [^1].\
Este *notebook* materializa o conhecimento aplicado ao permitir a análise interativa dos parâmetros da máquina.\
É considerado um alternador síncrono de polos salientes de $25\rm MVA$, $13,8 \rm kV$ e o seu funcionamento a $50 \rm Hz$. Sabem-se as reatâncias e as constantes de tempo que caracterizam o curto-circuito do alternador dados pelo fabricante:
"""

# ╔═╡ 92f54fc7-d648-4420-9b6a-29d84d8a54b6
md"""
| Reatâncias síncronas  | Constantes de tempo |
|:--:|:--:|
| $X''_d = 0.914 \Omega$ | $T''_d = 0.035 \rm s$ |  
| $X'_d = 1.767 \Omega$ | $T'_d = 0.882 \rm s$ |   
| $X_d = 9.522 \Omega$ | $T_a = 0.177 \rm s$ |
**Nota:** tabela de dados com reatâncias a 60Hz (a converter para 50Hz).

"""

# ╔═╡ 0df313cf-d5f2-4336-91e8-b2f61e16a704
Foldable("Onde:", md"
 $X''_d$: reatância síncrona subtransitória (devido às barras amortecedoras)

 $X'_d$: reatância síncrona transitória

 $X_d$: reatância síncrona segundo o eixo direto

 $T''_d$: constante de tempo subtransitória  (devido às barras amortecedoras)

 $T'_d$: constante de tempo transitória

 $T_a$: constante de tempo do estator (decaimento da componente contínua)
")

# ╔═╡ a129072c-cc00-4dfc-81a2-5f04fb8f67b7


# ╔═╡ 3aed5229-dfb1-4440-b85d-7734461578a6
md"""
# Dados
"""

# ╔═╡ 22202004-bfaf-4d6d-8800-d0098089e5e0
Sₙ, Uₙ, f, f₀ = 25e6, 13.8e3, 50, 60;

# ╔═╡ 282eb870-4cbc-40b6-9224-8c8edad6c954
Xdʼʼ, Xdʼ, Xd = round.(f/f₀*[0.914, 1.767, 9.522], digits=3)

# ╔═╡ c50f75ce-1955-4a27-b829-44f4b4a04a95
Tdʼʼ, Tdʼ, Tₐ = 0.035, 0.882, 0.177;

# ╔═╡ ba2f738d-b82f-4da8-a05c-b9221bc7245b
begin
	E₀ = Uₙ/√3
	Iₙ = Sₙ /(√3*Uₙ)
	E₀, Iₙ = round.(Int, [E₀, Iₙ])
end

# ╔═╡ edf1ebfe-c13f-49e5-b222-048ee8529a94


# ╔═╡ 9ec64d72-baa3-417b-8c3f-c3989b96814e
md"""
# Corrente de curto-circuito do alternador
"""

# ╔═╡ 0221326a-605b-40aa-ab08-4fe03055dfec
md"""
O transitório da corrente de curto-circuito de um alternador síncrono em vazio é caracterizado por duas componentes distintas: 
- **Componente alternada (CA)**: oscila à frequência da rede e apresenta uma amplitude que decresce exponencialmente ao longo do tempo;
- **Componente contínua (CC)**: surge devido ao valor instantâneo da tensão no momento da falha e decresce exponencialmente até zero.

A corrente total de curto-circuito resulta da soma destas duas componentes, originando uma forma de onda assimétrica que evolui ao longo de três regimes característicos: **subtransitório**, **transitório** e **regime permanente** (ou estacionário).
"""

# ╔═╡ 83efce27-23e9-4a59-b79e-7cd3816788bb
md"""
No caso de um alternador síncrono trifásico de polos salientes, apenas a componente sobre o eixo direto surge durante o curto-circuito trifásico, por o alternador se encontrar previamente em vazio:
"""

# ╔═╡ f6dbe725-4b80-4dd2-9bf0-d46cdec9f86a
let
# raw_url -> on github draw.io file click the "Raw" button (top right, of file view) and then copy the URL from your browser address bar:
	raw_url = "https://raw.githubusercontent.com/Ricardo-Luis/me-2/refs/heads/main/draw/SCsynAlt/ShortCircuitAlternator.drawio"

# viewer_url build:
	viewer_url = "https://viewer.diagrams.net/?highlight=0000ff&edit=_blank&layers=1&nav=1#U" * raw_url

# HTML:
HTML("""
<iframe frameborder="0" style="width:100%;height:300px" 
        src="$(viewer_url)">
</iframe>
""")
end

# ╔═╡ 3e2d9c13-78a0-49c1-98d8-7c78616048ed


# ╔═╡ 36a6f923-685f-4a1f-8af4-686a77487903
md"""
Quando ocorre um curto-circuito súbito nos terminais do alternador, estabelece-se instantaneamente uma **corrente muito elevada no estator**, que cria um forte campo magnético girante. Por sua vez, por indução magnética (lei de Faraday) surge uma força eletromotriz no enrolamento de excitação, que provoca o aparecimento de uma corrente adicional, que se sobrepõe à corrente de excitação inicial: $$\quad i_f(t) = I_{f0} + \Delta i_f(t)\quad$$, fazendo a corrente total no rotor aumentar significativamente.

Ou seja, durante o curto-circuito, temos um sistema acoplado magneticamente entre o enrolamento de excitação (rotor) e os enrolamentos do estator (armadura).

**Efeito do curto-circuito trifásico:**

- A corrente induzida adicional **reforça** o campo magnético do rotor
- Este reforço **reduz** a reatância síncrona do eixo direto do alternador de $X_d$ para $X_d'$
- Resulta em correntes de curto-circuito mais elevadas ($I'$) no período inicial

A **resistência do rotor**, $R_f$, dissipa a energia da corrente induzida, $$\Delta i_f(t)$$, provocando o seu decaimento exponencial. Este decaimento é determinada sobretudo pela constante de tempo transitória $T_d'$.

**Efeito do amortecimento da corrente de excitação:**

- A reatância aumenta progressivamente de $X_d'$ para $X_d$
- A amplitude da componente CA da corrente de curto-circuito diminui de $I'$ para $I$
- No final do transitório, a corrente de excitação retoma o valor inicial: $\quad i_f(\infty) = I_{f0}$


Durante o **período subtransitório** (muito mais curto), um fenómeno semelhante ocorre nas **barras amortecedoras** (quando existem), com correntes induzidas que decrescem ainda mais rapidamente $(T_d'' \ll T_d')$. 

As barras amortecedoras são condutores metálicos curto-circuitados nas extremidades, instalados nas cabeças das peças polares do rotor de máquinas síncronas. A sua função primária é amortecer oscilações mecânicas face a grandes perturbações de funcionamento, mas durante o curto-circuito comportam-se como enrolamentos secundários, conduzindo correntes induzidas de grande magnitude que decrescem rapidamente.
"""

# ╔═╡ d385a5b9-decb-46af-9683-3f0bb05e04e7


# ╔═╡ 19e3e5f1-1a7e-4d7c-9e67-8cde3e743067

md"""
## Componente CA da corrente de curto-circuito
"""

# ╔═╡ cb824d1e-eccd-4fdb-92f4-6734a5b5b398
md"""
A componente alternada da corrente de curto-circuito é caracterizada por uma amplitude variável no tempo, que reflete as alterações nos circuitos magnéticos do rotor:

**Período subtransitório** (primeiros ciclos):
- Duração muito curta;
- Corrente muito elevada devido à baixa reatância síncrona, $X_d''$;
- Esta componente é devido às correntes induzidas nas **barras amortecedoras** do rotor, que se opõem à variação súbita do fluxo magnético.

**Período transitório** (ciclos seguintes):
- Corrente ainda elevada, mas inferior ao período anterior;
- Amortecimento da correntes induzida no enrolamento de excitação;
- Caracterizado pela constante de tempo $T_d'$ e reatância $X_d'$.

**Período permanente** (regime estacionário):
- Corrente mantém-se constante em amplitude;
- Determinada pela reatância síncrona, $X_d$, e pela força eletromotriz, $E_0$;
- Mantém-se indefinidamente enquanto persistir o curto-circuito.

A transição entre estes períodos é determinada pelas constantes de tempo, $T_d''$ e $T_d'$, que dependem das características eletromagnéticas do alternador.

Em $(1)$ apresenta-se o modelo matemático aproximado da evolução temporal da componente CA das correntes de curto-circuito de cada uma das fases:
"""

# ╔═╡ cf14f85b-0b98-4fac-8a3c-ed8a01acea04
md"""
$$\tag{1}
i_k^{\text{ac}}(t) = \sqrt{2} E_0 \left[ \left( \frac{1}{X_d''} - \frac{1}{X_d'} \right) e^{-\frac{t}{T_d''}} + \left( \frac{1}{X_d'} - \frac{1}{X_d} \right) e^{-\frac{t}{T_d'}} + \frac{1}{X_d} \right] \sin\left( \omega t + \alpha + \varphi + \theta_k \right)\qquad$$
"""

# ╔═╡ f739b445-4928-4bac-8263-7be8b444392b
md"""
com:\
$\qquad k = \{1, 2, 3\}, \:\:\text{fases 1, 2 e 3 do alternador}$\
$\qquad E_0 \text{: força eletromotriz por fase}$\
$\qquad \omega = 2\pi f, \:\:\text{velocidade angular elétrica}$ \
$\qquad \alpha \text{:}\textbf{ ângulo de falha }(\text{posição angular da tensão no momento que antecede o curto-circuito, } t=0^-)$\
$\qquad \varphi = -\dfrac{\pi}{2}, \:\:\text{posição angular da corrente em relação à força eletromotriz (deprezando a resistência estatórica)}$\
$\qquad \theta_k = \bigl[0, \dfrac{-2π}{3}, \dfrac{2π}{3}\bigr],\:\:\text{posição angular relativa entre as fases 1, 2 e 3}$
"""

# ╔═╡ f3d503e8-9bf7-4010-9b9c-63ac7deed103


# ╔═╡ bc723dc3-455d-483b-86f8-ff93f4d8c751
md"""
A expansão da expressão de $(1)$, permite segmentar as parcelas nos períodos: subtransitório, transitório e estacionário, $(2)$:
"""

# ╔═╡ 6271aff5-46c0-4054-a07c-a6f0bffbb166
md"""
$$i_k^{\text{ac}}(t) = \underbrace{\left(\frac{\sqrt{2} E_0}{X_d''} - \frac{\sqrt{2} E_0}{X_d'}\right) e^{-\frac{t}{T_d''}} \sin\left(\omega t + \alpha + \varphi + \theta_k\right)}_{\textbf{período subtransitório}} \: + \: \underbrace{\left(\frac{\sqrt{2} E_0}{X_d'} - \frac{\sqrt{2} E_0}{X_d}\right) e^{-\frac{t}{T_d'}} \sin\left(\omega t + \alpha + \varphi + \theta_k\right)}_{\textbf{período transitório}} \: + \: \underbrace{\frac{\sqrt{2} E_0}{X_d} \sin\left(\omega t + \alpha + \varphi + \theta_k\right)}_{\textbf{período estacionário}}\qquad \tag{2}$$
"""

# ╔═╡ bd3abdf6-c73f-424c-a8e5-a9bcc0b1bb7e
md"""
A expressão $(1)$ pode ser representado por $(3)$:  
"""

# ╔═╡ 02f68b6a-ef07-448e-9f8c-965496177e13
md"""
$\tag{3}
i_k^{\text{ac}}(t) = \left[\left(I'' - I'\right) e^{-\frac{t}{T_d''}} + \left(I' - I\right) e^{-\frac{t}{T_d'}} + I \right] \sin\left( \omega t + \alpha + \varphi + \theta_k \right)$
"""

# ╔═╡ 9c3e9360-fc5a-48fb-8812-f508f0399de6
md"""
Onde:\
 $\quad I''\:$: corrente máxima do período subtransitório\
 $\quad I'\:$: corrente máxima do período transitório\
 $\quad I\:$: corrente máxima do período estacionário\
"""

# ╔═╡ 1edc0d8b-0d59-416f-9808-ae3daf775356


# ╔═╡ b55b6ee5-ff29-4c40-a958-b1c303994e3f
md"""
Computacionalmente, tem-se o intervalo de tempo para cálculo das correntes de curto-circuito do alternador e as componentes CA do curto-circuito trifásico:
"""

# ╔═╡ 096119ef-8291-44a0-bcbc-3c8033c281f1
t = 0:0.001:5;

# ╔═╡ b573972e-a464-4a32-bc70-1e2a668c5825


# ╔═╡ 14dab71f-ea8d-4048-af48-7714165935a3
md"""
## Componente CC da corrente de curto-circuito
"""

# ╔═╡ 296df781-64db-4d66-b732-8888e57c23f6
md"""
A **componente contínua** (CC) da corrente de curto-circuito surge devido ao princípio físico de que **o fluxo ligado a um circuito indutivo não pode variar instantaneamente**.

Assim, no instante anterior ao curto-circuito ($t=0^-$), o alternador está em vazio:
- Corrente no estator: $\qquad i_k(0^-) = 0$
- Fluxo ligado ao estator: $\; \psi_k(0^-) = L_{kk} \; i_k(0^-) = 0\;$. Em que, $L_{kk}$ representa a indutância própria do estator.

No instante do curto-circuito ($t=0^+$), a tensão nos terminais, $U_k$, cai abruptamente a zero, mas:
- **O fluxo ligado não pode variar instantaneamente**: $\; \psi_k(0^+) = \psi_k(0^-) = 0$
- Para manter $\psi_k = 0\;$, enquanto surge a componente CA (que criaria fluxo alternado), é necessária uma **componente contínua** que compense e mantenha o fluxo total nulo, no instante inicial;
- Esta componente CC surge instantaneamente para **garantir a continuidade do fluxo ligado**, ou seja: $$\;\psi_k(t) = L_{kk} \left[ i_k^{\text{ac}}(t) + i_k^{\text{dc}}(t) \right]\;$$. Assim, em $\; t=0^+ \;$, tem-se: $$\;\psi_k(0^+) = 0 \Rightarrow i_k^{\text{dc}}(0^+) = -i_k^{\text{ac}}(0^+)$$

Portanto, a componente CC tem um valor inicial que equilibra o valor inicial da componente CA da corrente de curto-circuito, garantindo a continuidade do fluxo.

A evolução temporal da componente CC, vem dada por, $(4)$:
"""

# ╔═╡ a5b969d0-d700-427f-85b4-6f44b49090d5
md"""
$\begin{align}
i_k^{\text{dc}}(t) &= \sqrt{2} \frac{E_0}{X_d''} 
\sin\left( \alpha + \varphi + \theta_k \right) e^{-\frac{t}{T_a}} \qquad \text{, com barras amortecedoras}\\
\\[-5mm]
i_k^{\text{dc}}(t) &= \sqrt{2} \frac{E_0}{X_d'} 
\sin\left( \alpha + \varphi + \theta_k \right) e^{-\frac{t}{T_a}} \qquad \text{, sem barras amortecedoras}\\
\end{align}
\tag{4}$
"""

# ╔═╡ 07c8d694-52d6-4a5c-8887-f26998df0b4e
md"""
De $(4)$ verifica-se que:
- O valor máximo ocorre para um ângulo de falha, $\alpha = 90°$. Isso significa que, se o curto-circuito ocorrer no momento em que a força eletromotriz (relativa à primeira fase) passa por zero, a componente CA associada iniciará no seu máximo:

$\begin{align}
I_{cc}^{dc_{máx}} &= \sqrt{2} \frac{E_0}{X_d''} \quad \text{(com barras amortecedoras)}\\
\\[-5mm]
I_{cc}^{dc_{máx}} &= \sqrt{2} \frac{E_0}{X_d'} \quad \text{(sem barras amortecedoras)}\\
\end{align}$
- Decaimento exponencial com constante de tempo $T_a$, devido à dissipação da energia da componente CC na resistência dos enrolamentos do estator, $R_a$.
"""

# ╔═╡ 27b6fd52-d59b-4a43-9962-00cdc3694bb3
md"""
Computacionalmente, tem-se as componentes CC do curto-circuito trifásico:
"""

# ╔═╡ f78f0bbe-7e44-4985-adc0-918d5bc7e997


# ╔═╡ cdc19447-0a40-49d5-a992-3848eb7f9f08
md"""
## Corrente de curto-circuito e envolventes
"""

# ╔═╡ f346e683-ff83-4fd7-9099-547a739535ef
md"""
A corrente de curto-circuito do alternador, $i_k(t)$, vem dada pela soma das componentes CA e CC, $(5)$:
"""

# ╔═╡ 83fdb910-fe1b-41d2-ab8c-01f528f22328
md"""
$\tag{5}
i_k(t) = i_k^{\text{ac}}(t) + i_k^{\text{dc}}(t)$
"""

# ╔═╡ c30ba538-fefe-4c36-9ea1-cf1d52d7b98f


# ╔═╡ 43b98570-0623-4644-ad75-db0c09953e34
md"""
As envolventes das correntes de curto-circuito, $i_k^{env}(t)$, obtêm-se retirando a função seno de $i_k(t)$, $(6)$:
"""

# ╔═╡ 96d77db8-b6a9-49ea-8bd3-47c5fa252100
md"""
$\begin{align}
i_{k}^{\text{env}P}(t) &= \sqrt{2} E_0 \left[ \left( \frac{1}{X_d''} - \frac{1}{X_d'} \right) e^{-\frac{t}{T_d''}} + \left( \frac{1}{X_d'} - \frac{1}{X_d} \right) e^{-\frac{t}{T_d'}} + \frac{1}{X_d} \right] + i_{k}^{\text{dc}} \\

i_{k}^{\text{env}N}(t) &= -\sqrt{2} E_0 \left[ \left( \frac{1}{X_d''} - \frac{1}{X_d'} \right) e^{-\frac{t}{T_d''}} + \left( \frac{1}{X_d'} - \frac{1}{X_d} \right) e^{-\frac{t}{T_d'}} + \frac{1}{X_d} \right] + i_{k}^{\text{dc}}
\end{align}
\tag{6}$
"""

# ╔═╡ b287fb68-1d55-4590-8143-89a1d424e370


# ╔═╡ 17984570-cac9-4a8f-93df-1dbba973be2b
md"""
## 💻 Gráfico das correntes de curto-circuito
"""

# ╔═╡ d4baa0c1-005f-4a11-9128-d698f565fdd8
md"""
Ajuste o ângulo de falha, $\alpha$, e observe a(s) corrente(s) de curto-circuito simétricas do alternador síncrono:

- a evolução das três parcelas (subtransitória, transitória, permanente);
- as envolventes das correntes de curto-circuito, $i_k^{env}(t)$;
- a componente contínua (CC) e o seu decaimento com $T_a$;
- os valores de pico inicial, $I''$, e permanente, $I$.
"""

# ╔═╡ 32920b61-49df-44c2-90ed-a1826ed143a2
md"""
---
"""

# ╔═╡ d70a14d1-3ff3-4e7a-84b2-bb08fe91956b
Columns(md"""Seletor das correntes:\
		  $$\qquad$$ $(@bind seletor MultiSelect(["i₁", "i₂", "i₃", "i₁ᵉⁿᵛ", "i₂ᵉⁿᵛ", "i₃ᵉⁿᵛ"]; default=["i₃", "i₃ᵉⁿᵛ"]))
		  """, md"""
		Ângulo de falha, $$\alpha$$, 
		
		  $(@bind α Slider(0:1:360, default=0, show_value=true))$$\degree$$ \
		
		(instante do curto-circuito)		
		""",
		md"""Intervalo de tempo:
		  
		 $$\:\: t_{\text{min}}$$ $(@bind Xmin Slider(0:0.01:2.5, default=0, show_value=false))
		
		 $$\:\: t_{\text{max}}$$ $(@bind Xmax Slider(0.1:0.01:5, default=5, show_value=false)) 
		  """)

# ╔═╡ b1d68348-6466-458f-ac1a-7bcb77ba42d9
begin
	i₁ᵃᶜ = √2E₀*((1/Xdʼʼ-1/Xdʼ)*exp.(-t/Tdʼʼ) .+ (1/Xdʼ-1/Xd)*exp.(-t/Tdʼ) .+ 1/Xd).*sin.(2π*f*t .+ deg2rad(α) .- π/2)
	
	i₂ᵃᶜ = √2E₀*((1/Xdʼʼ-1/Xdʼ)*exp.(-t/Tdʼʼ) .+ (1/Xdʼ-1/Xd)*exp.(-t/Tdʼ) .+ 1/Xd).*sin.(2π*f*t .+ deg2rad(α) .- π/2 .- 2π/3)
	
	i₃ᵃᶜ = √2E₀*((1/Xdʼʼ-1/Xdʼ)*exp.(-t/Tdʼʼ) .+ (1/Xdʼ-1/Xd)*exp.(-t/Tdʼ) .+ 1/Xd).*sin.(2π*f*t .+ deg2rad(α) .- π/2 .+ 2π/3)
end;

# ╔═╡ 221be9e2-9b2f-47dd-9807-deaa71ee5b92
begin
	i₁ᵈᶜ = √2*(E₀/Xdʼʼ)*sin(deg2rad(α) - π/2) .* exp.(-t/Tₐ)
	i₂ᵈᶜ = √2*(E₀/Xdʼʼ)*sin(deg2rad(α) - π/2 - 2π/3) .* exp.(-t/Tₐ)
	i₃ᵈᶜ = √2*(E₀/Xdʼʼ)*sin(deg2rad(α) - π/2 + 2π/3) .* exp.(-t/Tₐ)
end;

# ╔═╡ 1d7ee720-387f-4c6f-b282-aa55fd969d10
begin
	i₁ = i₁ᵃᶜ + i₁ᵈᶜ  
	i₂ = i₂ᵃᶜ + i₂ᵈᶜ 
	i₃ = i₃ᵃᶜ + i₃ᵈᶜ  
end;

# ╔═╡ 494fb8f8-2b95-410b-b6fb-635b482d7a73
begin
	i₁ᵉⁿᵛᴾ = √2E₀*((1/Xdʼʼ-1/Xdʼ)*exp.(-t/Tdʼʼ) .+ (1/Xdʼ-1/Xd)*exp.(-t/Tdʼ) .+ 1/Xd) + i₁ᵈᶜ 
	i₁ᵉⁿᵛᴺ = -√2E₀*((1/Xdʼʼ-1/Xdʼ)*exp.(-t/Tdʼʼ) .+ (1/Xdʼ-1/Xd)*exp.(-t/Tdʼ) .+ 1/Xd) + i₁ᵈᶜ 
	
	i₂ᵉⁿᵛᴾ = √2E₀*((1/Xdʼʼ- 1/Xdʼ)*exp.(-t/Tdʼʼ) .+ (1/Xdʼ-1/Xd)*exp.(-t/Tdʼ) .+ 1/Xd) + i₂ᵈᶜ 
	i₂ᵉⁿᵛᴺ = -√2E₀*((1/Xdʼʼ- 1/Xdʼ)*exp.(-t/Tdʼʼ) .+ (1/Xdʼ-1/Xd)*exp.(-t/Tdʼ) .+ 1/Xd) + i₂ᵈᶜ 
	
	i₃ᵉⁿᵛᴾ = √2E₀*((1/Xdʼʼ-1/Xdʼ)*exp.(-t/Tdʼʼ) .+ (1/Xdʼ-1/Xd)*exp.(-t/Tdʼ) .+ 1/Xd) + i₃ᵈᶜ  
	i₃ᵉⁿᵛᴺ = -√2E₀*((1/Xdʼʼ-1/Xdʼ)*exp.(-t/Tdʼʼ) .+ (1/Xdʼ-1/Xd)*exp.(-t/Tdʼ) .+ 1/Xd) + i₃ᵈᶜ  
end;

# ╔═╡ 8f414dc5-216b-404f-b19b-fdd005f8316b
begin
	correntes = [(i₁, "i₁"), (i₂, "i₂"), (i₃, "i₃"), ([i₁ᵉⁿᵛᴾ, i₁ᵉⁿᵛᴺ], "i₁ᵉⁿᵛ"), ([i₂ᵉⁿᵛᴾ, i₂ᵉⁿᵛᴺ], "i₂ᵉⁿᵛ"), ([i₃ᵉⁿᵛᴾ, i₃ᵉⁿᵛᴺ], "i₃ᵉⁿᵛ")]

	p = plot( xaxis=[Xmin, Xmax], yaxis=[-30e3, 30e3], 
			xlabel="\$t \\textrm{\\;\\; (s)}\$", legendfontsize=11, ylabel="Corrente(s) de curto-circuito (kA)", 
			yticks=(-30e3:10e3:30e3, [-30 -20 -10 0 10 20 30]), size=[700,400]
			)

	for (signal, name) in correntes
    	if name in seletor
        	plot!(t, signal, label=name, 
				  title="1 - Correntes de curto-circuito temporais do estator")
    	end
	end
	p
end

# ╔═╡ 9d630b0e-29f6-4dd3-9d24-7998d3166b70


# ╔═╡ aa5795f2-ff47-49cc-a2fb-597ca71029f5
md"""
# Análise da corrente curto-circuito (de uma das fases)
"""

# ╔═╡ 3eeb83f5-bad8-4774-8416-3e630e343f3a
md"""
A análise da corrente de curto-circuito permite obter:

- as correntes de curto-circuito máximas (componente CA): subtransitória, $I''$, transitória, $I'$, e de regime permanente, $I$;
- A corrente de curto-circuito máxima (incluindo a componente de corrente contínua), $I_{cc}^{máx}$;
- as reatâncias síncronas: subtransitória, $X''_d$, transitória, $X'_d$, e de regime permanente, $X_d$;
- constantes de tempo: subtransitória, $T''_d$, transitória, $T'_d$, e da armadura (estator), $T_a$.
"""

# ╔═╡ 0db24c69-91bb-4208-bfd8-22c432aa1b5e
md"""
Assim, a análise quantitativa das correntes de curto-circuito permite não só compreender o fenómeno transitório, mas também determinar experimentalmente os parâmetros característicos da máquina síncrona. Este processo de identificação de parâmetros é fundamental para a validação de dados fornecidos pelo fabricante e para a modelação precisa da máquina em estudos de sistemas de potência.
"""

# ╔═╡ 451574e2-b28c-42d1-aa0b-cea5990ece86


# ╔═╡ 8713ad11-8df8-4c6a-891d-32edf2dea948
md"""
## Extração da componente contínua
"""

# ╔═╡ d3683113-63a5-4d13-a5e0-26bb11ce5fda
md"""
A componente contínua da corrente de curto-circuito, $i_k^{dc}(t)$, pode ser isolada geometricamente, determinando o valor intermédio entre as envolventes da corrente de curto-circuito, $(7)$:
"""

# ╔═╡ 5d11f908-4a59-48ed-9c70-8da0c7dcacf1
md"""
$\tag{7}
i_k^{\text{dc}}(t)=\frac{i_{k}^{\text{env}P}(t) + i_{k}^{\text{env}N}(t)}{2}$
"""

# ╔═╡ 8d621346-6d2d-48ca-b65e-90325f2c892e
md"""
Exemplo extraindo a $i_3^{dc}$:
"""

# ╔═╡ 7123cde9-4efe-48fb-afcb-b04c7623b7da
begin
	plot(t, i₃ᵉⁿᵛᴾ, label="\$i_3^{\\textrm{env}P}\$", 
		 			ylabel="Corrente de curto-circuito (kA)")
	plot!(t, i₃ᵉⁿᵛᴺ, label="\$i_3^{\\textrm{env}N}\$", 
		  			 yaxis=[-30e3, 30e3], size=[700, 400],
					 yticks=(-30e3:10e3:30e3, [-30 -20 -10 0 10 20 30]))
	plot!(t, i₃ᵈᶜ, label="\$i_3^{dc}\$", lw=2, title="2 - Componente CC", 
		  		   xlabel="\$t \\textrm{\\;\\; (s)}\$", legendfontsize=11)
	plot!(t, (i₃ᵉⁿᵛᴾ .+ i₃ᵉⁿᵛᴺ)/2, label="cálculo \$i_3^{dc}\$", lw=2)
end

# ╔═╡ 4f0b5c24-2bae-4710-ac87-52fd33dccb5f
md"""
Note-se que a componente CC da corrente de curto-circuito depende da posição angular, $\alpha$, da tensão (igual à força eletromotriz) no momento que antecede o curto-circuito. O resultado atual do gráfico 2 relativo à componente CC da corrente da fase 3, está apresentado considerando $\alpha=$ $(α)°.
"""

# ╔═╡ dd4635a7-373d-444f-b1e4-6095056f6527


# ╔═╡ a4462b73-3282-4ac3-902c-99828ce936bb
md"""
## Obtenção da componente transitória
"""

# ╔═╡ b8a00e75-0dc7-4052-9f71-efad992fb62d
md"""
Envolvente da corrente de curto-circuito sem a componente contínua (exemplo para a fase 3):
"""

# ╔═╡ e65a7f5a-9722-46c7-a9ad-35640c7c48e4
plot(t, i₃ᵉⁿᵛᴾ-i₃ᵈᶜ, label= "envolvente de \$i_3^{ac}\$", legend=:bottomright,
	 				 lw=2, yaxis=[-30e3, 30e3],
					 yticks=(-30e3:10e3:30e3,[-30, -20, -10, 0 ,10, 20, 30]),
					 title="3 - Envolvente CA", size=[700, 400],
	 				 xlabel="\$t \\textrm{\\;\\; (s)}\$", legendfontsize=11, 
					 ylabel="Corrente de curto-circuito (kA)")

# ╔═╡ c8eca392-f1d3-4ad1-a996-6ef11e6e6cc7
md"""
A representação da envolvente da componente CA da corrente de curto-circuito num gráfico semilogarítmico permite evidenciar os decaimentos exponenciais, que aparecem como retas proporcionais na escala logarítmica:
"""

# ╔═╡ fe91d744-8fe1-4674-9fc8-a180a35c6f47
plot(t, i₃ᵉⁿᵛᴾ.- i₃ᵈᶜ, yscale=:log10, xlims=[0,5], label=:none, yticks=20, 
	 	size=[700, 400], title="4 - Gráfico semi-logarítmico",
	 	xlabel="\$t \\textrm{\\;\\; (s)}\$", legendfontsize=11,
	 	ylabel="Corrente de curto-circuito (A), escala log₁₀")

# ╔═╡ 51e6707f-2906-4921-b59e-73ae853b041c


# ╔═╡ f3dfed46-ddcb-4dc1-a654-682402a217f7
md"""
**Corrente de curto-circuito fase 3 (sem componente CC)**\
Representar sinusoide da corrente de curto-circuito? $(@bind z CheckBox())
"""

# ╔═╡ 637523c1-729f-49f9-ab11-3ce41e660a47
if z==:false 
	plot(t, i₃ᵉⁿᵛᴾ-i₃ᵈᶜ, label= "envolvente período subtransitório", 
		 				lc=:green, lw=2, yaxis=[-15e3, 15e3],
						yticks=(-15e3:5e3:15e3,[-15, -10, -5, 0 ,5, 10, 15]))
	plot!(t, i₃ᵉⁿᵛᴾ .- i₃ᵈᶜ.- √2E₀*((1/Xdʼʼ-1/Xdʼ)*exp.(-t/Tdʼʼ)), 
		  	lw=2, xaxis=[0, 5], lc=:purple, size=[700, 400], legend=:bottomright, 
			label= "envolvente período transitório + reg. permanente",
		    title="5 - Corrente de curto-circuito fase 3 (sem componente CC)", 
			xlabel="\$t \\textrm{\\;\\; (s)}\$", legendfontsize=11,
		    ylabel="Corrente de curto-circuito (kA)",)	
else
	plot(t, i₃ᵃᶜ, label="\$i_3^{ac}\$")
	plot!(t, i₃-i₃ᵈᶜ, label="\$i_3 - i_3^{dc}= i_3^{ac}\$")
	plot!(t, i₃ᵉⁿᵛᴾ-i₃ᵈᶜ, label= "envolvente período subtransitório", 
		  				lc=:green, lw=2, yaxis=[-15e3, 15e3],
						yticks=(-15e3:5e3:15e3,[-15, -10, -5, 0 ,5, 10, 15]))
	plot!(t, i₃ᵉⁿᵛᴾ .- i₃ᵈᶜ.- √2E₀*((1/Xdʼʼ-1/Xdʼ)*exp.(-t/Tdʼʼ)), 
		  	lw=2, xaxis=[0, 5],  lc=:purple, size=[700, 400], legend=:bottomright, 
			label= "envolvente período transitório + regime permanente",
		    title="5 - Corrente de curto-circuito fase 3 (sem componente CC)",
			xlabel="\$t \\textrm{\\;\\; (s)}\$", legendfontsize=11, 
		    ylabel="Corrente de curto-circuito (kA)")
end

# ╔═╡ d05129bc-f313-4015-be2a-7baadade1d64


# ╔═╡ 6182cfe7-09e5-42b7-b099-d342491fc1ce
md"""
## Correntes máximas de curto-circuito
"""

# ╔═╡ f14324bf-571b-458b-8604-387c27508940
md"""
Nesta secção são obtidas a partir dos gráficos 4 ou 5, as correntes máximas dos períodos estacionário, $I$, transitório, $I'$, e subtransitório, $I''$.
"""

# ╔═╡ c68c360e-bb24-4597-ab9b-88e481069889
I = 1441

# ╔═╡ 42264626-5fe1-49c4-9b66-922a03421625
md"""
- Corrente máxima da corrente durante o regime permanente do curto-circuito, $I=$ $(round(I/1000, digits=1)) $$\rm{kA}$$;
"""

# ╔═╡ 9aaf18f6-2d1e-4e96-9028-b7c7edfcaaed


# ╔═╡ 99e068c1-894d-4033-8f79-babfe50e0ba1
md"""
A partir do gráfico semi-logarítmico (gráfico 4), a corrente máxima do período transitório, $I'$, é determinada utilizando a inclinação predominande desse período:
"""

# ╔═╡ 15fc4a73-e39f-4254-a03b-3954becbbf92
Iʼ = 10^3.88

# ╔═╡ 19d21193-40ca-4a40-a627-a1cd5ce3fca4
md"""
- Corrente máxima da corrente durante o regime transitório do curto-circuito:
 $I'=$ $(round(Iʼ/1000, digits=1)) $$\rm{kA}$$;
"""

# ╔═╡ 693e918c-20f7-498f-b661-8210a8cc9e7c


# ╔═╡ c8e0da9b-c906-4aa7-a23b-9856075dccac
md"""
O valor máximo da corrente no período subtransitório, $I''$, obtém-se da envolvente CA (sem componente CC), em $(t=0 \rm{s})$: 
"""

# ╔═╡ 27e08a96-4433-4863-ae70-436f029acf4b
Iʼʼ= 14.786e3

# ╔═╡ a3638e5b-755a-4852-b9cd-532dbc326f85
md"""
- Corrente máxima da corrente durante o regime subtransitório do curto-circuito:
 $I''=$ $(round(Iʼʼ/1000, digits=1)) $$\rm{kA}$$;
"""

# ╔═╡ 4b9bfe70-990b-4828-9dac-1edcc2af4a1e


# ╔═╡ 9677c373-b53e-4f9b-9cd9-671fcd9eeee8
md"""
## Reatâncias síncronas do curto-circuito
"""

# ╔═╡ 3858413f-4e3d-4f3b-b18d-342d33d0ff95
md"""
A observação das correntes máximas $I'', I', I$, possibilita obter as respetivas reatâncias, $(8)$: 
"""

# ╔═╡ 18114a77-d7ea-4f31-8286-95d6992ee66f
md"""
$\begin{align}
X''_d &= \frac{\sqrt2E_0}{I''}\\[3mm]
X'_d &= \frac{\sqrt2E_0}{I'}\\[3mm]
X_d &= \frac{\sqrt2E_0}{I}\\
\end{align}
\tag{8}$
"""

# ╔═╡ 15222bbc-5cd6-4e8f-8292-daa056496b8a
md"""
Assim obtêm-se, sucessivamente:
"""

# ╔═╡ 2214fb25-a346-4338-9edc-5e29ad162c0b
begin
	xd = √2*E₀/I
	xd = round(xd, digits=3)
end

# ╔═╡ 19a03e2f-9040-4104-9328-ffcd16e0b8c0
md"""
- Reatância síncrona segundo o eixo direto, $$x_d=$$ $(xd) $$\Omega$$.
"""

# ╔═╡ 2998f27f-7983-43e6-8ead-1ed9c32e07ec
begin
	xdʼ = √2*E₀/Iʼ
	xdʼ = round(xdʼ, digits=3)
end

# ╔═╡ 4eb8f6f2-b466-4592-90d9-7ae000d3b53d
md"""
- Reatância síncrona transitória, $$x'_d=$$ $(xdʼ) $$\Omega$$.
"""

# ╔═╡ e57941d4-8ae1-47ed-9803-4f5d25f67f97
begin
	xdʼʼ = √2*E₀/Iʼʼ
	xdʼʼ = round(xdʼʼ, digits=3)
end

# ╔═╡ 0d57d6ec-377c-4f2e-91c6-db024aa7b817
md"""
- Reatância síncrona subtransitória, $$x''_d=$$ $(xdʼʼ) $$\Omega$$.
"""

# ╔═╡ fa079320-c39c-4aab-aacc-689baccb9ec3


# ╔═╡ f8d46b46-faa6-48d3-a54e-e97817481b65
md"""
## Constantes de tempo
"""

# ╔═╡ 89172a2f-0aec-441e-b18a-0e19b5e932e0
md"""
As constantes de tempo subtransitória, $T''_d$, transitória, $T'_d$, e da armadura, $T_a$, são obtidas analisando os decaimentos exponenciais da corrente, [^3]. 
Por definição, após um intervalo de tempo igual à constante de tempo, a grandeza exponencial decresce para aproximadamente $36.8\%$ do seu valor inicial (correspondente a $\; e^{-1} \approx 0,368$).
"""

# ╔═╡ cfdc1c31-2738-4361-ab53-be4c9eb02888
md"""
O decaimento da corrente de curto-circuito da componente subtransitória, $\Delta I''$, $(9)$, vem dada por:

$\tag{9}
\Delta I'' = 0.368(I'' - I')$
"""

# ╔═╡ 8640a015-96c1-458a-a1e1-c29c78cd1b48
ΔIʼʼ =  (Iʼʼ-Iʼ)*exp(-1)

# ╔═╡ 98599a79-e797-4be7-b9ab-0715bbb39964
md"""
A função exponencial associada à componente subtransitória não decresce até zero, mas sim até ao valor máximo da corrente de curto-circuito da componente transitória, $I'$.\
Para determinar a constante de tempo $T''_d$, considera-se a corrente de curto-circuito correspondente ao decaimento de cerca de $36.8\%$ da componente subtransitória, que é dada por:
"""

# ╔═╡ 1b826ece-5c43-408b-a7e1-78bbaddfb6ce
I➡τdʼʼ = ΔIʼʼ + Iʼ 

# ╔═╡ f2fe67da-ecba-475f-a58f-bf26cfb03bab
md"""
Consultando o gráfico 5, verifica-se que o tempo correspondente à constante de tempo transitória, vem dada por:
"""

# ╔═╡ 04f3b655-2e69-4b8a-a51e-f514a3937c48
τdʼʼ = 0.033 # read in the graph n.5 at the I➡τdʼʼ value

# ╔═╡ 548ecb83-f3db-4e5e-a015-347c37e807b1
md"""
Da mesma forma o decaimento da corrente de curto-circuito da componente transitória, $\Delta I'$, vem dada por $(10)$:

$\tag{10}
\Delta I' = 0.368(I' - I) \quad\quad\quad \text{, onde:  } \quad e^{-1} \approx 0.368$
"""

# ╔═╡ e560af71-5a50-46f6-8097-6345a2dedec1
ΔIʼ = (Iʼ- I)*exp(-1)

# ╔═╡ b961162b-755e-4625-b301-d91932a18074
I➡τdʼ = ΔIʼ+I

# ╔═╡ 829c7b3e-994f-4f9d-84e9-24d6c2fe2a7d
md"""
Consultando um dos gráficos (4 ou 5), verifica-se que o tempo correspondente à constante de tempo transitória, vem dada por:
"""

# ╔═╡ e31e2ad6-cd8b-4f26-9826-691abd83ff8a
τdʼ = 0.887 # read in the graph n.5 at the I➡τdʼ value

# ╔═╡ 62ca92bc-fb1a-4b29-b1fe-360895877db5


# ╔═╡ 12e745a9-bd8f-4c55-8a08-307ad947d5b3
md"""
A constante de tempo da armadura é obtida pela análise do decaimento da componente CC da corrente de curto-circuito:
"""

# ╔═╡ 510600cd-3de4-4d2b-8296-f4723063c7c0
plot(t, i₃ᵈᶜ, xticks=20, label="\$i_3^{dc}\$",  size=[700, 400], lw=2,										 title="6 - Componente CC do curto-circuito",
						 yaxis=[-15e3, 15e3], ylabel="Componente CC (kA)",
	 					 yticks=(-15e3:5e3:15e3,[-15, -10, -5, 0 ,5, 10, 15]),
						 xlabel="\$t \\textrm{\\;\\; (s)}\$", legendfontsize=11)

# ╔═╡ 83f92eaa-02bb-4a46-a989-02d9ae4d0c74
md"""
Do gráfico 6, obtém-se sucessivamente:
"""

# ╔═╡ 1a2d4211-e42f-48a0-b1d7-6b62c7e6c026
I₃ᵈᶜ = i₃ᵈᶜ[1]  	# value at t=0 s

# ╔═╡ 12853183-f264-4015-b7f2-a4f2f0421755
ΔI₃ᵈᶜ =  I₃ᵈᶜ*exp(-1)

# ╔═╡ 2692d457-7f1e-4808-bb8f-3344387c374a
md"""
Consultando o valor do decaimento da corrente da componente CC no gráfico 6, obtém-se a contante de tempo da armadura:
"""

# ╔═╡ 57863975-5545-44db-ac02-9e5725eef09e
τₐ = 0.177

# ╔═╡ 8d709388-a509-4ef9-97b8-e35545b7f6c3


# ╔═╡ 263353e9-9829-418b-a98c-41d368a72b21
md"""
# Resumo de resultados
"""

# ╔═╡ f0bb7a7b-34ab-4b6d-8f88-e228ce2da6f4
md"""
Adicionalmente determina-se a corrente máxima da componente CC que pode ocorrer no curto-circuito em qualquer das fases, $i_k^{dc_{max}}(t=0)$, $(11)$:
"""

# ╔═╡ af92d350-582c-4549-bf8a-a8dc7670cbc5
md"""
$\tag{11}
i_k^{dc_{max}}(t=0) = \sqrt{2} \frac{E_0}{X_d''}$
"""

# ╔═╡ 1b8545d1-0525-4a22-b203-1b559a5781ce
begin
	Iᵈᶜₘₐₓ = √2 * E₀ / xdʼʼ
	Iᵈᶜₘₐₓ =round(Iᵈᶜₘₐₓ, digits=0)
end

# ╔═╡ 3176d029-3bc0-46ba-92b8-c1d5f560b8e3
md"""
- Componente contínua máxima, $$I_{cc}^{dc_{máx}}=$$ $(round(Iᵈᶜₘₐₓ/1000, digits=1)) $$\rm{kA}$$.
"""

# ╔═╡ 8756a7b6-901f-4ec5-9162-f209089fa1a5


# ╔═╡ 1a857462-ac98-43b0-99d5-a9c9e79016ce
md"""
O que significa que a corrente máxima que pode ocorrer numa das fases no início do curto-circuito trifásico do alternador é o dobro da corrente máxima da componente subtransitória.

Por conseguinte, tém-se $(12)$:

$\tag{12}
I_{cc}^{máx} = I'' +I_{cc}^{dc_{máx}}$
"""

# ╔═╡ 316197f3-8580-43fa-a0e0-af0e37bfa2c2
Iccₘₐₓ = Iʼʼ + Iᵈᶜₘₐₓ

# ╔═╡ 298ce739-3389-4006-a066-c34698c886a3
md"""
- Corrente de curto-circuito máxima, $$I_{cc}^{máx}=$$ $(round(Iccₘₐₓ/1000, digits=1)) $$\rm{kA}$$.
"""

# ╔═╡ 91bcffa9-178c-4aa0-9873-38a8a29f960f


# ╔═╡ 10f0abae-f3cc-44b7-9ae5-bf91a6a93b67
md"""
O valor eficaz (máximo) que pode ocorrer no curto-circuito trifásico do alternador tem em conta as duas componentes CA e CC, $(13)$:

$\tag{13}
I_{cc}^{rms} = \sqrt{(I'')^2 + (I_{cc}^{dc_{máx}})^2}$
"""

# ╔═╡ f236b276-a037-473a-9382-673eab1863d0
begin
	Iccʳᵐˢ = √(Iʼʼ^2 + Iᵈᶜₘₐₓ^2)
	Iccʳᵐˢ = round(Iccʳᵐˢ, digits=0)
end

# ╔═╡ 68d797c1-bce7-49d4-9de0-8074e13235f6
md"""
- Valor eficaz da corrente de curto-circuito máxima, $$I_{cc}^{rms}=$$ $(round(Iccʳᵐˢ/1000, digits=1)) $$\rm{kA}$$.
"""

# ╔═╡ 9f1777ee-76c6-49a1-9045-a56748018d3a


# ╔═╡ 0e5e5d95-a06d-47db-85b5-d190a067ee67
md"""
## Quadros resumo
"""

# ╔═╡ c529a527-9296-477b-890b-2ffa61fe5051
md"""
| Correntes de curto-circuito | (kA) |
|---:|:---:|
| Componente subtransitória máxima, $I''$: | $(round(Iʼʼ/1000, digits=1)) |
| Componente transitória máxima, $I'$: | $(round(Iʼ/1000, digits=1)) |
| Regime permanente (valor máximo), $I$: | $(round(I/1000, digits=1)) |
| Componente contínua máxima, $I_{cc}^{dc_{máx}}$: | $(round(Iᵈᶜₘₐₓ/1000, digits=1)) |
| Corrente de curto-circuito máxima, $I_{cc}^{máx}$: | $(round(Iccₘₐₓ/1000, digits=1)) |
| Valor eficaz da corrente de curto-circuito máxima, $I_{cc}^{rms}$: | $(round(Iccʳᵐˢ/1000, digits=1)) |
"""

# ╔═╡ c1ad4570-7148-4c69-9761-9237ea810b97


# ╔═╡ ba875b89-8e3f-4125-a8d4-d12710b641fc
md"""
| Parâmetros | Originais | Determinação | Erro relativo (%)|
|---:|:---:|:---:|:---:|
| Reatância subtransitória, $X''_d \:(\Omega)$: |  $(Xdʼʼ) | $(xdʼʼ)  | 0.0  |
| Reatância transitória, $X'_d \:(\Omega)$: | $(Xdʼ) | $(xdʼ)  | $(round((xdʼ-Xdʼ)*100/Xdʼ, digits=2))  |
| Reatância síncrona eixo direto, $X_d \:(\Omega)$: | $(Xd) | $(xd)  | $(round((xd-Xd)*100/Xd, digits=2))    |
| Constante de tempo subtransitória, $T''_d \:(\rm s)$: | $(Tdʼʼ) | $(τdʼʼ)  | $(round((τdʼʼ-Tdʼʼ)*100/Tdʼ, digits=2)) |
| Constante de tempo transitória, $T'_d \:(\rm s)$: | $(Tdʼ) |  $(τdʼ) | $(round((τdʼ-Tdʼ)*100/Tdʼ, digits=2))  |
| Constante de tempo da armadura, $T_a \:(\rm s)$: | $(Tₐ) | $(τₐ)  | 0.0  |
"""

# ╔═╡ a250a185-bd9f-4b57-9f47-a65e0486ddc6
md"""
Note-se que os erros relativos são muito baixos, pois os resultados foram obtidos a partir do modelo teórico do regime dinâmico do curto-circuito trifásico do alternador e não de um resultado experimental.
"""

# ╔═╡ fe4f24dd-2321-41d1-897b-0801d965e148


# ╔═╡ 81b0724a-5562-4389-b261-82f0f241d8e3
md"""
# Transitório da corrente do rotor
"""

# ╔═╡ 58e7ea39-4c2d-41be-81ea-09b33c9be6a0
md"""
!!! warning "Nota:"
	O modelação do transitório da corrente do rotor que ocorre durante o curto-circuito trifásico aos terminais do estator do alternador síncrono requer estudos avançados em [Complementos de Máquinas Elétricas](https://www.isel.pt/sites/default/files/FUC_202425_3482.pdf). Portanto, utilizaram-se equações específicas para representar o comportamento transitório do rotor nesse cenário.
"""

# ╔═╡ ae12fb45-82ed-4793-985a-c1c231a3b0f7
md"""
Para representação do transitório da corrente no rotor foram utilizados valores por unidade (pu), através do modelo apresentado no exemplo 3.1, pg. 55, de [^2].

Por conseguinte, o resultado é meramente exemplificativo e não caracteriza o transitório da corrente no rotor da máquina síncrona de $25\;\rm MVA$ anteriormente analisada.

"""

# ╔═╡ a446230b-790d-4fa3-a45c-512a3fe34738
I𝚏₀ = 1;

# ╔═╡ 688f5861-4d7b-4587-bc6c-f8a0eab8b0af
Xdr, Rdr = 0.11, 0.05;

# ╔═╡ 7e5d9667-e397-434d-8297-d8ef4a34137e
Tdʼr = Xdr /(Rdr*2*π*f);

# ╔═╡ f4fbc4aa-e95e-46cb-aeaa-f151c9d05356
md"""
Cálculo da corrente rotórica, $i_f(t)$, adaptado de [^4]:
"""

# ╔═╡ 311527ad-47a4-4bfa-8f1b-9b44e80cc4d5
md"""
$i_f(t) = I_{f0} + I_{f0} \left( \frac{X_d - X_d'}{X_d'} \right) \left[ e^{-\frac{t}{T_d'}} - \left( 1 - \frac{T'_{dr}}{T_d''} \right) e^{-\frac{t}{T_d''}} - \left( \frac{T'_{dr}}{T_d''} \right) e^{-\frac{t}{T_a}} \cos\left( \omega t \right) \right]$
"""

# ╔═╡ 3a026946-a228-4269-a26e-e4825bae4c46
md"""
Da análise ao transitório da corrente rotórica, verifica-se que a componente CC da corrente de curto-circuito em cada fase gera uma componente alternada, associada ao transitório da corrente do rotor. Essa componente CA apresenta um decaimento exponencial da sua amplitude, determinado pela constante de tempo da armadura (estator), $T_a$.
"""

# ╔═╡ 3d349b98-3861-42bf-b489-272371d9dbb5
md"""
Da mesma forma, a componente CA rotórica gera uma componente contínua nas correntes de curto-circuito dos enrolamentos do estator. 
"""

# ╔═╡ bb709ca2-e531-4a57-95e3-5b8a2c19593b


# ╔═╡ 087f40d5-5466-4a6b-9c47-26327d81a46b
md"""
## Cálculos auxiliares
"""

# ╔═╡ 7de0328a-5958-4dfa-a64b-7aa30722060f
i𝚏 = I𝚏₀ .+ I𝚏₀ * ((Xd-Xdʼ)/Xdʼ)*(exp.(-t/Tdʼ) .- (1-Tdʼr/Tdʼʼ)*exp.(-t/Tdʼʼ) .- (Tdʼr/Tdʼʼ)*exp.(-t/Tₐ).*cos.(2π*f*t));

# ╔═╡ 6c0d42c4-9718-42ef-b315-efbc4901e849


# ╔═╡ 3d12d672-f0f3-4d7e-9325-8ff5b81f06ed
md"""
$\begin{aligned}
I_f^{\text{env}L}(t) &= I_{f0} + I_{f0} \left( \frac{X_d - X_d'}{X_d'} \right) \left[ e^{-\frac{t}{T_d'}} - \left( 1 - \frac{T'_{dr}}{T_d''} \right) e^{-\frac{t}{T_d''}} - \left( \frac{T'_{dr}}{T_d''} \right) e^{-\frac{t}{T_a}} \right] \\
\\
I_f^{\text{env}H}(t) &= I_{f0} + I_{f0} \left( \frac{X_d - X_d'}{X_d'} \right) \left[ e^{-\frac{t}{T_d'}} - \left( 1 - \frac{T'_{dr}}{T_d''} \right) e^{-\frac{t}{T_d''}} + \left( \frac{T'_{dr}}{T_d''} \right) e^{-\frac{t}{T_a}} \right]
\end{aligned}$
"""

# ╔═╡ 6500094b-fb25-4e6b-bbf7-0c2bd7dea34b
begin
	Ifᵉⁿᵛᴸ = I𝚏₀ .+ I𝚏₀ * ((Xd-Xdʼ)/Xdʼ)*(exp.(-t/Tdʼ) .- (1-Tdʼr/Tdʼʼ)*exp.(-t/Tdʼʼ) .- (Tdʼr/Tdʼʼ)*exp.(-t/Tₐ))

	Ifᵉⁿᵛᴴ = I𝚏₀ .+ I𝚏₀ * ((Xd-Xdʼ)/Xdʼ)*(exp.(-t/Tdʼ) .- (1-Tdʼr/Tdʼʼ)*exp.(-t/Tdʼʼ) .+ (Tdʼr/Tdʼʼ)*exp.(-t/Tₐ))
end;

# ╔═╡ 4cf98440-4b8b-4512-bdfd-e2b79a4f643a
md"""
$I_f^{\text{ave}}(t) = \frac{I_f^{\text{env}H}(t) + I_f^{\text{env}L}(t)}{2}$

"""

# ╔═╡ 16ba8314-8677-4c2c-bd70-41d338818502
Ifᵃᵛᵉ=(Ifᵉⁿᵛᴴ+Ifᵉⁿᵛᴸ)/2;

# ╔═╡ 57188395-80e7-42be-b1f7-ab1dacdb4a40
begin
	plot(t, i𝚏, yaxis=[0, 6], xticks=15, label="\$i_f(t)\$",
		 		title="Transitório da corrente rotórica")
	plot!(t, Ifᵉⁿᵛᴸ, label="\$I_f^{\\textrm{env}L}(t)\$", 
		  			 xlabel="\$t \\textrm{\\;\\; (s)}\$",  
		  			 ylabel="corrente rotórica (pu)")
	plot!(t, Ifᵉⁿᵛᴴ, label="\$I_f^{\\textrm{env}H}(t)\$", size=[700, 400])
	plot!(t, Ifᵃᵛᵉ, label="\$I_f^{\\textrm{ave}}(t)\$", lc=:black, legendfontsize=11)
end

# ╔═╡ 1c6c0b6a-eb71-42f9-9ac8-1d5fe8339cbb


# ╔═╡ a9f55de8-790c-454e-bd2a-279f960f0d6b
md"""
# Importância da Análise do Transitório

A análise do transitório do curto-circuito trifásico de um alternador em vazio é crucial para a engenharia de sistemas elétricos de potência, apresentando aplicações práticas essenciais como:

- **Dimensionamento de proteções**: Os dispositivos de proteção (disjuntores, relés) devem ser especificados considerando não apenas a corrente de regime permanente, mas sobretudo os valores de pico que ocorrem nos primeiros ciclos do curto-circuito. O valor eficaz simétrico da corrente subtransitória $I''$ e a corrente de pico assimétrica $I_{cc}^{máx}$ determinam a capacidade de interrupção necessária dos disjuntores;

- **Projeto de sistemas de aterramento**: As componentes CC das correntes de curto-circuito influenciam significativamente as tensões de passo e toque durante falhas, sendo determinantes para o dimensionamento de malhas de terra;

- **Estudos de estabilidade transitória**: Os parâmetros transitórios e subtransitórios $(X_d', X_d'', T_d', T_d'')$ são fundamentais para a análise da resposta dinâmica do sistema elétrico face a perturbações, determinando se o sistema permanecerá estável após a eliminação da falta;

- **Coordenação de proteções**: O conhecimento preciso da evolução temporal das correntes de curto-circuito permite estabelecer ajustes adequados de seletividade e coordenação entre diferentes níveis de proteção.

"""

# ╔═╡ 5fc9c419-7db4-498c-9bbe-af91d0d68828


# ╔═╡ ad5f9fe4-c4a5-4b5a-a337-febe52733459
md"""
# Bibliografia
"""

# ╔═╡ e4da46c0-9ec7-4ee8-bbf4-3315a2302a5f
md"""
[^1]: Anastázia Margitová, Martin Kanálik, Michal Kolcun, *Verification of synchronous generator time constants given by manufacturers using the short-circuit current calculation*, Proc. of the 10ᵗʰ Int. Scientific Symposium on Electrical Power Engineering, ELEKTROENERGETIKA 2019, 16-18 September 2019, Stara Lesna, Slovakia, pp. 515 - 520.

[^2]: Ion Boldea, Lucian N. Tutelea, *Electric Machines -- Transients, Control Principles, Finite Element Analysis, and Optimal Design with* MATLAB®, 2ⁿᵈ Ed., CRC Press, 2022. 

[^3]: J. C. Das, *Power system analysis: short-circuit load flow and harmonics*, Marcel Dekker, 2002.

[^4]: O. Chiver, L. Neamt, O. Matei, _Comparative Study On Sudden Short-Circuit Currents Of A Synchronous Generator_, IEEE 15ᵗʰ Int. Conf. On Environment And Electrical Engineering (EEEIC), 2015, DOI: [10.1109/EEEIC.2015.7165426](https://doi.org/10.1109/EEEIC.2015.7165426)
"""

# ╔═╡ a140ea41-5872-4f52-9d44-4e2314c9e216
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

# ╔═╡ 83a8151a-3259-48a9-8386-c55484a9f719
md"""
# _Notebook_
"""

# ╔═╡ c6a5b92d-a3bc-401f-b7ad-790bcacc7026
md"""
Documentação das bibliotecas `Julia` utilizadas: [Plots](http://docs.juliaplots.org/latest/), [PlutoUI](https://featured.plutojl.org/basic/plutoui.jl), [PlutoTeachingTools.jl](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html).
"""

# ╔═╡ d3557937-ae73-4939-9f78-ba2764e45735
begin
	version=VERSION
	md"""
*Notebook* desenvolvido em `Julia` versão $(version).
"""
end

# ╔═╡ d82e7ab4-214d-4666-8d63-85ce21225cca
md"""
!!! info "Informação"
	No índice deste *notebook*, os tópicos assinalados com "💻" requerem a participação do estudante.
"""

# ╔═╡ f1d78f7a-570a-4983-b7b0-a1a56b706506
TableOfContents(title="Índice", depth=4)

# ╔═╡ 98f9357c-6530-40cf-84e9-a30b756b3715
md"""
|  |  |
|:--:|:--|
|  | This notebook, [SCsynAlt.jl](https://ricardo-luis.github.io/me-2/SCsynAlt.html), is part of the collection "[_Notebooks_ Computacionais Aplicados a Máquinas Elétricas II](https://ricardo-luis.github.io/me-2/)" by Ricardo Luís. |
| **Terms of Use** | All narrative and visual content is shared under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)), while the Julia code snippets are released under the [MIT License](https://www.tldrlegal.com/license/mit-license).|
|  | $©$ 2022-2026 [Ricardo Luís](https://ricardo-luis.github.io) |
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Plots = "~1.41.7"
PlutoTeachingTools = "~0.4.7"
PlutoUI = "~0.7.83"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.13.0"
manifest_format = "2.1"
project_hash = "117d659571d66e82f2e1daf410ffbcd8835abcf6"

[[deps.AbstractPlutoDingetjes]]
git-tree-sha1 = "e71ee7b4aa06b045259a7d6101e1cb45ad140bce"
registries = "General"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.4.1"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
registries = "General"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
registries = "General"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "1fa950ebc3e37eccd51c6a8fe1f92f7d86263522"
registries = "General"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.7+0"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "b0fd3f56fa442f81e0a47815c92245acfaaa4e34"
registries = "General"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.31.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
registries = "General"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "8b3b6f87ce8f65a2b4f857528fd8d70086cd72b1"
registries = "General"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.11.0"

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "37ea44092930b1811e666c3bc38065d7d87fcc74"
registries = "General"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.1"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.5.5+2"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
registries = "General"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
registries = "General"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["OrderedCollections"]
git-tree-sha1 = "b0bc6d2cad1fed8b7fd59a1551a991cb3d2809e6"
registries = "General"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.19.6"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "473e9afc9cf30814eb67ffa5f2db7df82c3ad9fd"
registries = "General"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.16.2+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
registries = "General"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
registries = "General"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.7.0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a4be429317c42cfae6a7fc03c31bad1970c310d"
registries = "General"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+1"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "2bfb1e047e2ad0a5ca94365340bde8005d637568"
registries = "General"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.8.4+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "95ecf07c2eea562b5adbd0696af6db62c0f52560"
registries = "General"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.5"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libva_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "7a58e45171b63ed4782f2d36fdee8713a469e6e0"
registries = "General"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "8.1.2+0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Random", "Statistics"]
git-tree-sha1 = "59af96b98217c6ef4ae0dfe065ac7c20831d1a84"
registries = "General"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.6"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "f85dac9a96a01087df6e3a749840015a0ca3817d"
registries = "General"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.17.1+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
registries = "General"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "70329abc09b886fd2c5d94ad2d9527639c421e3e"
registries = "General"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.14.3+1"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7a214fdac5ed5f59a22c2d9a885a16da1c74bbc7"
registries = "General"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.17+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "64bbbb7d1499297751b536dd39c58b20750ab1db"
registries = "General"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.5.1+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "JSON", "Libdl", "LinearAlgebra", "Preferences", "Printf", "Qt6Wayland_jll", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "p7zip_jll"]
git-tree-sha1 = "4d777f73c46b46b8b5276206059cf8a195499314"
registries = "General"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.27"

    [deps.GR.extensions]
    IJuliaExt = "IJulia"

    [deps.GR.weakdeps]
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "f8eb8f7ba13ea75083531647fc8faeda8d541f07"
registries = "General"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.27+0"

[[deps.GettextRuntime_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll"]
git-tree-sha1 = "45288942190db7c5f760f59c04495064eedf9340"
registries = "General"
uuid = "b0724c58-0f36-5564-988d-3bb0596ebc4a"
version = "0.22.4+0"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Zlib_jll"]
git-tree-sha1 = "38044a04637976140074d0b0621c1edf0eb531fd"
registries = "General"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.1+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "GettextRuntime_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "090526e65de8f69648ac156daae153de8b56df62"
registries = "General"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.88.3+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "69ffb934a5c5b7e086a0b4fee3427db2556fba6e"
registries = "General"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.16+0"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "9d9531a9cb63a9edc33836414e82a07e81710de2"
registries = "General"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "100.14004.0+0"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
registries = "General"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "d1a86724f81bcd184a38fd284ce183ec067d71a0"
registries = "General"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "1.0.0"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "0ee181ec08df7d7c911901ea38baf16f755114dc"
registries = "General"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "1.0.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "b2d91fe939cae05960e760110b328288867b5758"
registries = "General"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.6"

[[deps.JLFzf]]
deps = ["REPL", "Random", "fzf_jll"]
git-tree-sha1 = "82f7acdc599b65e0f8ccd270ffa1467c21cb647b"
registries = "General"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.11"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7204148362dafe5fe6a273f855b8ccbe4df8173e"
registries = "General"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.8.0"

[[deps.JSON]]
deps = ["Dates", "Logging", "Parsers", "PrecompileTools", "StructUtils", "UUIDs", "Unicode"]
git-tree-sha1 = "88352712893ec50bee3680605891eaf0e9ed6368"
registries = "General"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "1.8.0"

    [deps.JSON.extensions]
    JSONArrowExt = ["ArrowTypes"]

    [deps.JSON.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "037babc10853eeb8e585418922246cb97b8e5b74"
registries = "General"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.2.0+1"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "059aabebaa7c82ccb853dd4a0ee9d17796f7e1bc"
registries = "General"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.3+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "39bca05343661c347aae0bca57a5994a0bf4f08d"
registries = "General"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "4.2.0+0"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e5b100780d4d30d63b4618d7930d48af409c1772"
registries = "General"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "23.1.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f88f3ccef05a6a72a0cf0ed417c8fd68530f4ab2"
registries = "General"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.1"

[[deps.Latexify]]
deps = ["Format", "Ghostscript_jll", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "df7566479bd64f20bd16b09960145e70160ffb3b"
registries = "General"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.12"

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
version = "1.0.0"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "Zlib_jll", "Zstd_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.18.0+1"

[[deps.LibGit2]]
deps = ["LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "PCRE2_jll", "Zlib_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.9.1+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl", "OpenSSL_jll", "Zlib_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.103+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c8da7e6a91781c41a863611c7e966098d783c57a"
registries = "General"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.4.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "d36c21b9e7c172a44a10484125024495e2625ac0"
registries = "General"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.1+1"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
registries = "General"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "cc3ad4faf30015a3e8094c9b5b7f19e85bdf2386"
registries = "General"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.42.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "aebd334d06cee9f24cea70bd19a39749daf73881"
registries = "General"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.3+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d620582b1f0cbe2c72dd1d5bd195a9ce73370ab1"
registries = "General"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.42.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.13.0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "bba2d9aa057d8f126415de240573e86a8f39d2a1"
registries = "General"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "1.0.1"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
registries = "General"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
registries = "General"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.Measures]]
git-tree-sha1 = "b513cedd20d9c914783d8ad83d08120702bf2c77"
registries = "General"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.3"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
registries = "General"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2026.8.13"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "dbd2e8cd2c1c27f0b584f6661b4309609c5a685e"
registries = "General"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.4"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6aa4566bb7ae78498a5e68943863fa8b5231b59"
registries = "General"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.6+0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.30+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.7+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.6+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e2bb57a313a74b8104064b7efd01406c0a50d2ff"
registries = "General"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.6.1+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "05f45c2e0de6259db764adbfd2f1dc6d3f8de13c"
registries = "General"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "2.0.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.46.0+0"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1912a9f1b9ca55005b03ba075f8e19993583e237"
registries = "General"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.58.2+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools"]
git-tree-sha1 = "663e8b48b789916221e0765393b289ca6c88f24e"
registries = "General"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "3.0.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "e4a6721aa89e62e5d4217c0b21bd714263779dda"
registries = "General"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.46.4+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "Zstd_jll", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.13.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "41031ef3a1be6f5bbbf3e8073f210556daeae5ca"
registries = "General"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.3.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "StableRNGs", "Statistics"]
git-tree-sha1 = "26ca162858917496748aad52bb5d3be4d26a228a"
registries = "General"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.4"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "TOML", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "83bd514e8ff16b5858ac54c53fa0bcf6002a3b00"
registries = "General"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.41.7"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "Latexify", "Markdown", "PlutoUI"]
git-tree-sha1 = "90b41ced6bacd8c01bd05da8aed35c5458891749"
registries = "General"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.4.7"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "e189d0623e7ce9c37389bac17e80aac3b0302e75"
registries = "General"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.83"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "edbeefc7a4889f528644251bdb5fc9ab5348bc2c"
registries = "General"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.3.4"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "8b770b60760d4451834fe79dd483e318eee709c4"
registries = "General"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.2"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.PtrArrays]]
git-tree-sha1 = "4fbbafbc6251b883f4d2705356f3641f3652a7fe"
registries = "General"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.4.0"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "144895f6166994730ee7ff8113b981fc360638f1"
registries = "General"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.10.2+2"

[[deps.Qt6Declarative_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6ShaderTools_jll", "Qt6Svg_jll"]
git-tree-sha1 = "159d253ab126d5b29230cf53521899bea4ef4648"
registries = "General"
uuid = "629bc702-f1f5-5709-abd5-49b8460ea067"
version = "6.10.2+2"

[[deps.Qt6ShaderTools_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "4d85eedf69d875982c46643f6b4f66919d7e157b"
registries = "General"
uuid = "ce943373-25bb-56aa-8eca-768745ed7b5a"
version = "6.10.2+1"

[[deps.Qt6Svg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "81587ff5ff25a4e1115ce191e36285ede0334c9d"
registries = "General"
uuid = "6de9746b-f93d-5813-b365-ba18ad4a9cf3"
version = "6.10.2+0"

[[deps.Qt6Wayland_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6Declarative_jll"]
git-tree-sha1 = "672c938b4b4e3e0169a07a5f227029d4905456f2"
registries = "General"
uuid = "e99dba38-086e-5de3-a5b1-6e4c66e897c3"
version = "6.10.2+1"

[[deps.REPL]]
deps = ["Base64", "Dates", "FileWatching", "InteractiveUtils", "JuliaSyntaxHighlighting", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
registries = "General"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
registries = "General"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
registries = "General"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
registries = "General"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
registries = "General"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "1.0.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "9b81b8393e50b7d4e6d0a9f14e192294d3b7c109"
registries = "General"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.3.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Showoff]]
deps = ["Dates"]
git-tree-sha1 = "8238217340ad0aaabe11afe39c1098b5bc9f4c8e"
registries = "General"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.1.1"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "13cd91cc9be159e3f4d95b857fa2aa383b53772a"
registries = "General"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.3"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.13.0"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "4f96c596b8c8258cc7d3b19797854d368f243ddc"
registries = "General"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.4"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "e2b53ce13a53367e96601081e33d34746b571bad"
registries = "General"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.5"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "178ed29fd5b2a2cfc3bd31c13375ae925623ff36"
registries = "General"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.8.0"

[[deps.StatsBase]]
deps = ["AliasTables", "DataAPI", "DataStructures", "IrrationalConstants", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "adb9da019510162e67a4493fc235c23203d8b09e"
registries = "General"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.13"

[[deps.StructUtils]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "2d0fc55c61321ba245c47be599570d11bac50303"
registries = "General"
uuid = "ec057cc2-7a8d-4b58-b3b3-92acb9f63b42"
version = "2.8.5"

    [deps.StructUtils.extensions]
    StructUtilsMeasurementsExt = ["Measurements"]
    StructUtilsStaticArraysCoreExt = ["StaticArraysCore"]
    StructUtilsTablesExt = ["Tables"]

    [deps.StructUtils.weakdeps]
    Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tables = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.10.1+0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
registries = "General"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.Tricks]]
git-tree-sha1 = "311349fd1c93a31f783f977a71e8b062a57d4101"
registries = "General"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.13"

[[deps.URIs]]
git-tree-sha1 = "908fec9df6c5de98548ead82a468c95ccf6cd263"
registries = "General"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.7.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
registries = "General"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
registries = "General"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
registries = "General"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "96478df35bbc2f3e1e791bc7a3d0eeee559e60e9"
registries = "General"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.24.0+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e52eca002a11c30a858185efdfb15311e1c7a6bf"
registries = "General"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.8.4+0"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a3ea76ee3f4facd7a64684f9af25310825ee3668"
registries = "General"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.2+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "9c7ad99c629a44f81e7799eb05ec2746abb5d588"
registries = "General"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.6+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "808090ede1d41644447dd5cbafced4731c56bd2f"
registries = "General"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.13+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aa1261ebbac3ccc8d16558ae6799524c450ed16b"
registries = "General"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.13+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "6c74ca84bbabc18c4547014765d194ff0b4dc9da"
registries = "General"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.4+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "52858d64353db33a56e13c341d7bf44cd0d7b309"
registries = "General"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.6+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "1a4a26870bf1e5d26cd585e38038d399d7e65706"
registries = "General"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.8+0"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "75e00946e43621e09d431d9b95818ee751e6b2ef"
registries = "General"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "6.0.2+0"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "dcb316b3ce0941f195537dda56bea4517fcd3ff5"
registries = "General"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.8.4+0"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll"]
git-tree-sha1 = "0ba01bc7396896a4ace8aab67db31403c71628f4"
registries = "General"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.7+0"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "6c174ef70c96c76f4c3f4d3cfbe09d018bcd1b53"
registries = "General"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.6+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "7ed9347888fac59a618302ee38216dd0379c480d"
registries = "General"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.12+0"

[[deps.Xorg_libpciaccess_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "58972370b81423fc546c56a60ed1a009450177c3"
registries = "General"
uuid = "a65dc6b1-eb27-53a1-bb3e-dea574b5389e"
version = "0.19.0+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXau_jll", "Xorg_libXdmcp_jll"]
git-tree-sha1 = "bfcaf7ec088eaba362093393fe11aa141fa15422"
registries = "General"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.1+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "ed756a03e95fff88d8f738ebc2849431bdd4fd1a"
registries = "General"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.2.0+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "9750dc53819eba4e9a20be42349a6d3b86c7cdf8"
registries = "General"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.6+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f4fc02e384b74418679983a97385644b67e1263b"
registries = "General"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll"]
git-tree-sha1 = "68da27247e7d8d8dafd1fcf0c3654ad6506f5f97"
registries = "General"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "44ec54b0e2acd408b0fb361e1e9244c60c9c3dd4"
registries = "General"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "5b0263b6d080716a02544c55fdff2c8d7f9a16a0"
registries = "General"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.10+0"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f233c83cad1fa0e70b7771e0e21b061a116f2763"
registries = "General"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.2+0"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "801a858fc9fb90c11ffddee1801bb06a738bda9b"
registries = "General"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.7+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "2e59214e017a55cb87474a00fa76035c82ac0e17"
registries = "General"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.47.0+2"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a63799ff68005991f9d9491b6e95bd3478d783cb"
registries = "General"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.6.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.3.1+2"

[[deps.Zstd_jll]]
deps = ["CompilerSupportLibraries_jll", "Libdl"]
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+1"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c3b0e6196d50eab0c5ed34021aaa0bb463489510"
registries = "General"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.14+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6a34e0e0960190ac2a4363a1bd003504772d631"
registries = "General"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.61.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "ef17c47d22224aaecc76e597ab21a072e025cf7b"
registries = "General"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.14.1+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "cb007192783c56d8249db4cf0e3495001edfe414"
registries = "General"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.17.5+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.15.0+0"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
registries = "General"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libdrm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libpciaccess_jll"]
git-tree-sha1 = "28e57478e8a160d346a19c28b3fffb9273bcc9c2"
registries = "General"
uuid = "8e53e030-5e6c-5a89-a30b-be5b7263a166"
version = "2.4.134+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "56d643b57b188d30cccc25e331d416d3d358e557"
registries = "General"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.13.4+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "646634dd19587a56ee2f1199563ec056c5f228df"
registries = "General"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.4+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "91d05d7f4a9f67205bd6cf395e488009fe85b499"
registries = "General"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.28.1+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "e51150d5ab85cee6fc36726850f0e627ad2e4aba"
registries = "General"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.58+0"

[[deps.libva_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll", "Xorg_libXfixes_jll", "libdrm_jll"]
git-tree-sha1 = "7dbf96baae3310fe2fa0df0ccbb3c6288d5816c9"
registries = "General"
uuid = "9a156e7d-b971-5f62-b2c9-67348b8fb97c"
version = "2.23.0+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll"]
git-tree-sha1 = "11e1772e7f3cc987e9d3de991dd4f6b2602663a5"
registries = "General"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.8+0"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b4d631fd51f2e9cdd93724ae25b2efc198b059b1"
registries = "General"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.7+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.67.1+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.8.2+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "14cc7083fc6dff3cc44f2bc435ee96d06ed79aa7"
registries = "General"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "10164.0.1+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e7b67590c14d487e734dcb925924c5dc43ec85f3"
registries = "General"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "4.1.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "a1fc6507a40bf504527d0d4067d718f8e179b2b8"
registries = "General"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.13.0+0"

[registries.General]
url = "https://github.com/JuliaRegistries/General.git"
uuid = "23338594-aafe-5451-b93e-139f81909106"
"""

# ╔═╡ Cell order:
# ╟─0176f110-acf2-11ef-1aa9-eff867ac861f
# ╟─c69f0608-04f7-4c40-aa9f-6a400d353d80
# ╟─0ecffabc-9301-489e-b1a0-d0993ff4b404
# ╟─92f54fc7-d648-4420-9b6a-29d84d8a54b6
# ╟─0df313cf-d5f2-4336-91e8-b2f61e16a704
# ╟─a129072c-cc00-4dfc-81a2-5f04fb8f67b7
# ╟─3aed5229-dfb1-4440-b85d-7734461578a6
# ╠═22202004-bfaf-4d6d-8800-d0098089e5e0
# ╠═282eb870-4cbc-40b6-9224-8c8edad6c954
# ╠═c50f75ce-1955-4a27-b829-44f4b4a04a95
# ╠═ba2f738d-b82f-4da8-a05c-b9221bc7245b
# ╟─edf1ebfe-c13f-49e5-b222-048ee8529a94
# ╟─9ec64d72-baa3-417b-8c3f-c3989b96814e
# ╟─0221326a-605b-40aa-ab08-4fe03055dfec
# ╟─83efce27-23e9-4a59-b79e-7cd3816788bb
# ╟─f6dbe725-4b80-4dd2-9bf0-d46cdec9f86a
# ╟─3e2d9c13-78a0-49c1-98d8-7c78616048ed
# ╟─36a6f923-685f-4a1f-8af4-686a77487903
# ╟─d385a5b9-decb-46af-9683-3f0bb05e04e7
# ╟─19e3e5f1-1a7e-4d7c-9e67-8cde3e743067
# ╟─cb824d1e-eccd-4fdb-92f4-6734a5b5b398
# ╟─cf14f85b-0b98-4fac-8a3c-ed8a01acea04
# ╟─f739b445-4928-4bac-8263-7be8b444392b
# ╟─f3d503e8-9bf7-4010-9b9c-63ac7deed103
# ╟─bc723dc3-455d-483b-86f8-ff93f4d8c751
# ╟─6271aff5-46c0-4054-a07c-a6f0bffbb166
# ╟─bd3abdf6-c73f-424c-a8e5-a9bcc0b1bb7e
# ╟─02f68b6a-ef07-448e-9f8c-965496177e13
# ╟─9c3e9360-fc5a-48fb-8812-f508f0399de6
# ╟─1edc0d8b-0d59-416f-9808-ae3daf775356
# ╟─b55b6ee5-ff29-4c40-a958-b1c303994e3f
# ╠═096119ef-8291-44a0-bcbc-3c8033c281f1
# ╠═b1d68348-6466-458f-ac1a-7bcb77ba42d9
# ╟─b573972e-a464-4a32-bc70-1e2a668c5825
# ╟─14dab71f-ea8d-4048-af48-7714165935a3
# ╟─296df781-64db-4d66-b732-8888e57c23f6
# ╟─a5b969d0-d700-427f-85b4-6f44b49090d5
# ╟─07c8d694-52d6-4a5c-8887-f26998df0b4e
# ╟─27b6fd52-d59b-4a43-9962-00cdc3694bb3
# ╠═221be9e2-9b2f-47dd-9807-deaa71ee5b92
# ╟─f78f0bbe-7e44-4985-adc0-918d5bc7e997
# ╟─cdc19447-0a40-49d5-a992-3848eb7f9f08
# ╟─f346e683-ff83-4fd7-9099-547a739535ef
# ╟─83fdb910-fe1b-41d2-ab8c-01f528f22328
# ╠═1d7ee720-387f-4c6f-b282-aa55fd969d10
# ╟─c30ba538-fefe-4c36-9ea1-cf1d52d7b98f
# ╟─43b98570-0623-4644-ad75-db0c09953e34
# ╟─96d77db8-b6a9-49ea-8bd3-47c5fa252100
# ╠═494fb8f8-2b95-410b-b6fb-635b482d7a73
# ╟─b287fb68-1d55-4590-8143-89a1d424e370
# ╟─17984570-cac9-4a8f-93df-1dbba973be2b
# ╟─d4baa0c1-005f-4a11-9128-d698f565fdd8
# ╟─32920b61-49df-44c2-90ed-a1826ed143a2
# ╟─d70a14d1-3ff3-4e7a-84b2-bb08fe91956b
# ╟─8f414dc5-216b-404f-b19b-fdd005f8316b
# ╟─9d630b0e-29f6-4dd3-9d24-7998d3166b70
# ╟─aa5795f2-ff47-49cc-a2fb-597ca71029f5
# ╟─3eeb83f5-bad8-4774-8416-3e630e343f3a
# ╟─0db24c69-91bb-4208-bfd8-22c432aa1b5e
# ╟─451574e2-b28c-42d1-aa0b-cea5990ece86
# ╟─8713ad11-8df8-4c6a-891d-32edf2dea948
# ╟─d3683113-63a5-4d13-a5e0-26bb11ce5fda
# ╟─5d11f908-4a59-48ed-9c70-8da0c7dcacf1
# ╟─8d621346-6d2d-48ca-b65e-90325f2c892e
# ╟─7123cde9-4efe-48fb-afcb-b04c7623b7da
# ╟─4f0b5c24-2bae-4710-ac87-52fd33dccb5f
# ╟─dd4635a7-373d-444f-b1e4-6095056f6527
# ╟─a4462b73-3282-4ac3-902c-99828ce936bb
# ╟─b8a00e75-0dc7-4052-9f71-efad992fb62d
# ╟─e65a7f5a-9722-46c7-a9ad-35640c7c48e4
# ╟─c8eca392-f1d3-4ad1-a996-6ef11e6e6cc7
# ╟─fe91d744-8fe1-4674-9fc8-a180a35c6f47
# ╟─51e6707f-2906-4921-b59e-73ae853b041c
# ╟─f3dfed46-ddcb-4dc1-a654-682402a217f7
# ╟─637523c1-729f-49f9-ab11-3ce41e660a47
# ╟─d05129bc-f313-4015-be2a-7baadade1d64
# ╟─6182cfe7-09e5-42b7-b099-d342491fc1ce
# ╟─f14324bf-571b-458b-8604-387c27508940
# ╟─42264626-5fe1-49c4-9b66-922a03421625
# ╠═c68c360e-bb24-4597-ab9b-88e481069889
# ╟─9aaf18f6-2d1e-4e96-9028-b7c7edfcaaed
# ╟─99e068c1-894d-4033-8f79-babfe50e0ba1
# ╟─19d21193-40ca-4a40-a627-a1cd5ce3fca4
# ╠═15fc4a73-e39f-4254-a03b-3954becbbf92
# ╟─693e918c-20f7-498f-b661-8210a8cc9e7c
# ╟─c8e0da9b-c906-4aa7-a23b-9856075dccac
# ╟─a3638e5b-755a-4852-b9cd-532dbc326f85
# ╠═27e08a96-4433-4863-ae70-436f029acf4b
# ╟─4b9bfe70-990b-4828-9dac-1edcc2af4a1e
# ╟─9677c373-b53e-4f9b-9cd9-671fcd9eeee8
# ╟─3858413f-4e3d-4f3b-b18d-342d33d0ff95
# ╟─18114a77-d7ea-4f31-8286-95d6992ee66f
# ╟─15222bbc-5cd6-4e8f-8292-daa056496b8a
# ╟─19a03e2f-9040-4104-9328-ffcd16e0b8c0
# ╠═2214fb25-a346-4338-9edc-5e29ad162c0b
# ╟─4eb8f6f2-b466-4592-90d9-7ae000d3b53d
# ╠═2998f27f-7983-43e6-8ead-1ed9c32e07ec
# ╟─0d57d6ec-377c-4f2e-91c6-db024aa7b817
# ╠═e57941d4-8ae1-47ed-9803-4f5d25f67f97
# ╟─fa079320-c39c-4aab-aacc-689baccb9ec3
# ╟─f8d46b46-faa6-48d3-a54e-e97817481b65
# ╟─89172a2f-0aec-441e-b18a-0e19b5e932e0
# ╟─cfdc1c31-2738-4361-ab53-be4c9eb02888
# ╠═8640a015-96c1-458a-a1e1-c29c78cd1b48
# ╟─98599a79-e797-4be7-b9ab-0715bbb39964
# ╠═1b826ece-5c43-408b-a7e1-78bbaddfb6ce
# ╟─f2fe67da-ecba-475f-a58f-bf26cfb03bab
# ╠═04f3b655-2e69-4b8a-a51e-f514a3937c48
# ╟─548ecb83-f3db-4e5e-a015-347c37e807b1
# ╠═e560af71-5a50-46f6-8097-6345a2dedec1
# ╠═b961162b-755e-4625-b301-d91932a18074
# ╟─829c7b3e-994f-4f9d-84e9-24d6c2fe2a7d
# ╠═e31e2ad6-cd8b-4f26-9826-691abd83ff8a
# ╟─62ca92bc-fb1a-4b29-b1fe-360895877db5
# ╟─12e745a9-bd8f-4c55-8a08-307ad947d5b3
# ╟─510600cd-3de4-4d2b-8296-f4723063c7c0
# ╟─83f92eaa-02bb-4a46-a989-02d9ae4d0c74
# ╠═1a2d4211-e42f-48a0-b1d7-6b62c7e6c026
# ╠═12853183-f264-4015-b7f2-a4f2f0421755
# ╟─2692d457-7f1e-4808-bb8f-3344387c374a
# ╠═57863975-5545-44db-ac02-9e5725eef09e
# ╟─8d709388-a509-4ef9-97b8-e35545b7f6c3
# ╟─263353e9-9829-418b-a98c-41d368a72b21
# ╟─f0bb7a7b-34ab-4b6d-8f88-e228ce2da6f4
# ╟─af92d350-582c-4549-bf8a-a8dc7670cbc5
# ╟─3176d029-3bc0-46ba-92b8-c1d5f560b8e3
# ╠═1b8545d1-0525-4a22-b203-1b559a5781ce
# ╟─8756a7b6-901f-4ec5-9162-f209089fa1a5
# ╟─1a857462-ac98-43b0-99d5-a9c9e79016ce
# ╟─298ce739-3389-4006-a066-c34698c886a3
# ╠═316197f3-8580-43fa-a0e0-af0e37bfa2c2
# ╟─91bcffa9-178c-4aa0-9873-38a8a29f960f
# ╟─10f0abae-f3cc-44b7-9ae5-bf91a6a93b67
# ╟─68d797c1-bce7-49d4-9de0-8074e13235f6
# ╠═f236b276-a037-473a-9382-673eab1863d0
# ╟─9f1777ee-76c6-49a1-9045-a56748018d3a
# ╟─0e5e5d95-a06d-47db-85b5-d190a067ee67
# ╟─c529a527-9296-477b-890b-2ffa61fe5051
# ╟─c1ad4570-7148-4c69-9761-9237ea810b97
# ╟─ba875b89-8e3f-4125-a8d4-d12710b641fc
# ╟─a250a185-bd9f-4b57-9f47-a65e0486ddc6
# ╟─fe4f24dd-2321-41d1-897b-0801d965e148
# ╟─81b0724a-5562-4389-b261-82f0f241d8e3
# ╟─58e7ea39-4c2d-41be-81ea-09b33c9be6a0
# ╟─ae12fb45-82ed-4793-985a-c1c231a3b0f7
# ╠═a446230b-790d-4fa3-a45c-512a3fe34738
# ╠═688f5861-4d7b-4587-bc6c-f8a0eab8b0af
# ╠═7e5d9667-e397-434d-8297-d8ef4a34137e
# ╟─f4fbc4aa-e95e-46cb-aeaa-f151c9d05356
# ╟─311527ad-47a4-4bfa-8f1b-9b44e80cc4d5
# ╟─57188395-80e7-42be-b1f7-ab1dacdb4a40
# ╟─3a026946-a228-4269-a26e-e4825bae4c46
# ╟─3d349b98-3861-42bf-b489-272371d9dbb5
# ╟─bb709ca2-e531-4a57-95e3-5b8a2c19593b
# ╟─087f40d5-5466-4a6b-9c47-26327d81a46b
# ╠═7de0328a-5958-4dfa-a64b-7aa30722060f
# ╟─6c0d42c4-9718-42ef-b315-efbc4901e849
# ╟─3d12d672-f0f3-4d7e-9325-8ff5b81f06ed
# ╠═6500094b-fb25-4e6b-bbf7-0c2bd7dea34b
# ╟─4cf98440-4b8b-4512-bdfd-e2b79a4f643a
# ╠═16ba8314-8677-4c2c-bd70-41d338818502
# ╟─1c6c0b6a-eb71-42f9-9ac8-1d5fe8339cbb
# ╟─a9f55de8-790c-454e-bd2a-279f960f0d6b
# ╟─5fc9c419-7db4-498c-9bbe-af91d0d68828
# ╟─ad5f9fe4-c4a5-4b5a-a337-febe52733459
# ╟─e4da46c0-9ec7-4ee8-bbf4-3315a2302a5f
# ╟─a140ea41-5872-4f52-9d44-4e2314c9e216
# ╟─83a8151a-3259-48a9-8386-c55484a9f719
# ╟─c6a5b92d-a3bc-401f-b7ad-790bcacc7026
# ╠═ccb548ca-265d-42fa-a64e-c6f0a29a17df
# ╟─d3557937-ae73-4939-9f78-ba2764e45735
# ╟─d82e7ab4-214d-4666-8d63-85ce21225cca
# ╠═f1d78f7a-570a-4983-b7b0-a1a56b706506
# ╟─98f9357c-6530-40cf-84e9-a30b756b3715
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
