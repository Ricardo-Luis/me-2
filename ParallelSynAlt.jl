### A Pluto.jl notebook ###
# v0.20.13

#> [frontmatter]
#> chapter = 2
#> section = 5
#> order = 5
#> image = "https://github.com/Ricardo-Luis/me-2/blob/565d82d9044a5f73dcd40b10f327d87134df4cc9/images/card/ParallelSynAlt.png?raw=true"
#> title = "📚 Paralelo de alternadores"
#> date = "2024-11-26"
#> tags = ["lecture", "module3"]
#> layout = "layout.jlhtml"
#> description = "Este notebook permite analisar o funcionamento de alternadores síncronos trifásicos ligados em paralelo numa rede isolada, explorando a interdependência entre máquinas na repartição de potência ativa e reativa, mantendo simultaneamente a tensão e a frequência estáveis. Através da análise das relações, U=f(Q)  e  freq=f(P), são discutidos os mecanismos de regulação de tensão e de frequência e a sua influência na distribuição de cargas entre os alternadores. Cada alternador possui a sua própria corrente de excitação e potência mecânica de acionamento, sendo analisado como as variações destes parâmetros individuais afetam o equilíbrio dinâmico da rede e os diferentes modos de operação conjunta"
#> 
#>     [[frontmatter.author]]
#>     name = "Ricardo Luís"
#>     url = "https://ricardo-luis.github.io/"

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

# ╔═╡ 3875d7ad-e592-4d50-84ad-760a35a16801
using PlutoUI, PlutoTeachingTools, Plots
#= 
Brief description of the used Julia packages:
  - PlutoUI.jl, to add interactivity objects
  - PlutoTeachingTools.jl, to enhance the notebook
  - Plots.jl, visualization interface and toolset to build graphics
=#

# ╔═╡ 0f8cd1bd-6abf-4466-a30c-a359afbda4cc
TwoColumnWideLeft(md"`ParallelSynAlt.jl`", md"`Last update: 26·11·2024`")

# ╔═╡ cf40074a-ccd7-4304-8ed7-1572a25acbb3
md"""
---
$\textbf{MÁQUINAS ELÉTRICAS SÍNCRONAS TRIFÁSICAS}$

$\text{PARALELO DE ALTERNADORES SÍNCRONOS 3 ∼}$ 

$\textbf{Regulação de tensão e frequência}$
$\text{e}$ 
$\textbf{Repartição de carga entre alternadores}$
---
"""

# ╔═╡ e41f8a12-e203-4624-87c2-a7e2771c3a6c
md"""
Neste _notebook_, analisam-se as relações entre a frequência e a potência ativa, $f=\rm{f}$$(P)$, bem como entre a tensão e a potência reativa, $U=\rm{f}$$(Q)$, no paralelo de alternadores síncronos trifásicos em rede isolada. Através destas funções são explorados os princípios de operação em grupos alternadores para manter constantes a frequência e a tensão de funcionamento da rede, face a variações de cargas ativas e reativas. Conjuntamente é analisada a repartição de carga (ativa e reativa) entre os alternadores, bem como esta pode ser ajustada na operação da redes elétricas isoladas.


"""

# ╔═╡ 08a790cc-47cf-4764-9f75-8d0a72118501


# ╔═╡ 1a4596e3-e949-4c3a-9a5a-c02cd02fcfeb
md"""
# 💻 Máq. síncrona ligada à rede elétrica $\quad$ $(@bind go Button("Reset"))
"""

# ╔═╡ 01f8f66b-8101-4296-86ec-0a0aba26c368
md"""
Do ensaio da máquina síncrona sob a rede elétrica de "potência infinita", $(f$ e $U)$ constantes, concluiu-se que a máquina pode operar em **quatro quadrantes de funcionamento**: 
- alternador $(P>0)$, quadrantes $\rm I$ e $\rm II$;
- motor $(P<0)$, quadrantes $\rm III$ e $\rm IV$;
- sobreexcitado $(E_0 \cos \delta > U)$, quadrantes $\rm I$ e $\rm IV$;
- subexcitado $(E_0 \cos \delta < U)$, quadrantes $\rm II$ e $\rm III$;

E ainda com fator de potência unitário $(Q=0)$, como compensador síncrono $(P\approx0)$ e a "flutuar" na rede $(\overline{E}_0=\overline{U})$.
"""

# ╔═╡ 4ea01a5e-cb21-4135-a8e3-92f88eb2a322


# ╔═╡ e9a658d3-0f3a-4a0a-9da2-0d6074ca2af4
md"""
Assim, o funcionamento da máquina síncrona ligada à rede pode ser analisado por funções de $f=\rm{f}$$(P)$ e $U=\rm{f}$$(Q)$, em que a rede elétrica apresenta uma característica **astática**, ou **isócrona**, significando que assegura uma frequência e tensão praticamente invariantes. Tal deve-se à presença de múltiplos alternadores na rede elétrica e ao equilíbrio entre a produção e o consumo de energia.
"""

# ╔═╡ 552e5d38-2099-44fc-9b2d-5a6cb2e9e623
let
	go
	
md"""
| Pot. mecânica (pu) | Reg. turbina | $I_{exc}$ (pu)  | Reg. tensão  |
|:--:|:--:|:--:|:--:|
| $(@bind f₀ Slider(30:0.1:70, default=50)) | $(@bind sₚ NumberField(1:1:20, default=10))%  | $(@bind E₀ Slider(0.5:0.01:1.5, default=1)) | $(@bind sᵢ NumberField(1:1:20, default=10))% |
"""
end

# ╔═╡ f9f98ea7-e273-4d72-8100-20de86c75275


# ╔═╡ b2ed1ca3-a8b3-4a3a-b703-2a2ae3e5fb97
md"""
# 💻 Paralelo de alternadores síncronos
"""

# ╔═╡ e6a2d00e-1ce5-4526-8cd9-5db7ec666101
md"""
No funcionamento de alternadores síncronos em rede isolada, é essencial a regulação da frequência, $f$, e da tensão, $U$, para se mantenham sensivelmente constantes, face a variações de carga (ativa e reativa).

São analisadas duas situações:
- Regulação de $f$ e $U$, mantendo a repartição de carga entre os alternadores;
- Alteração da repartição de carga entre alternadores, mantendo $f$ e $U$ aproximadamente constantes.
"""

# ╔═╡ 71dfd868-44ad-4141-8c12-b11133613c66


# ╔═╡ 36a4237f-773d-4972-a764-eb1ee5a129c9
md"""
## Regulação de frequência e tensão
"""

# ╔═╡ 1238538d-8671-4936-8886-1e0df078b7a3
md"""
A regulação de frequência -- potência ativa de uma rede elétrica isolada formada por mais de que um alternador requer a operação simultânea dos reguladores de velocidade das turbinas que acionam os respetivos alternadores. Deste modo, são associadas curvas características que relacionam a frequência e a potência ativa, $f=\rm{f}$$(P)$ de cada grupo turbina-alternador.

Os sistemas de regulação de velocidade, e consequentemente da frequência de funcionamento da rede, apresentam características lineares, $f=\rm{f}$$(P)$, onde a inclinação destas retas características é designada por **estatismo**, apresentada usualmente nas unidades de $\rm {Hz/W}$. 

Por simplicidade e para uma melhor generalização, nos exemplos seguintes, as potências ativas e o estatismo vem apresentados em valores por unidade $\rm{(pu)}$ e em percentagem, $(\%)$, respetivamente. É ainda possível representar qualquer dos alternadores 1 e 2 numa situação prévia de funcionamento com carga inicial, alterando o valor da frequência inicial de $f=\rm{f}$$(P)$ desse alternador, através da variável, $f_0$.
"""

# ╔═╡ 6720a2a5-b7a5-4bb0-806f-3c171669459b
md"""
Similarmente, a regulação de tensão -- potência reativa da rede elétrica isolada requer a operação simultânea dos reguladores da tensão associados aos circuitos de excitação, ou excitatrizes, dos alternadores. Deste modo, são associadas curvas que assegurem um determinado estatismo na função $U=\rm{f}$$(Q)$, sobre a característica externa de tensão do alternador.
"""

# ╔═╡ 1093527c-87fb-4870-b398-2d927a738467


# ╔═╡ 5d16d469-5c5c-44de-b226-b7f86cf8f9de
md"""
### Regulação de frequência, $f=\rm{f}$$(P_1, P_2)\quad\quad$ $(@bind gof Button("Reset"))
"""

# ╔═╡ 3f05ebea-40fc-4733-9b6f-ce3b0a4bc813
let gof
md"""
|  Estatismo | Alternador 2  | Alternador 1  |
|---|:---:|:---:|
| $f_0$ (Hz):  |  $(@bind f₀₂ NumberField(30:1:70, default=50)) | $(@bind f₀₁ NumberField(30:1:70, default=50)) |
| Reg. turbina (%): |  $(@bind sₚ₂ NumberField(0.1:0.1:30, default=10)) | $(@bind sₚ₁ NumberField(0.1:0.1:30, default=10))  |

|  Carga ativa total (pu) | Atuação simultânea pot. mecânicas |
|:---:|:---:|
| $P_t:$ $(@bind Pₜ Slider(0:0.01:2, default=1,show_value=true)) | $(@bind Δf₀ Slider(-10:0.01:10, default=0)) |
"""
end

# ╔═╡ e28655a4-f7f9-44c0-9f68-b0c134bf6320


# ╔═╡ f47ff613-f7af-452e-9df0-1297c975f1bd
md"""
### Regulação de tensão, $U=\rm{f}$$(Q_1, Q_2)\quad\quad$ $(@bind goU Button("Reset"))
"""

# ╔═╡ 98ae640e-c8f9-4cff-8199-7377bd7c3f61
let goU
md"""
|  Estatismo | Alternador 2  | Alternador 1  |
|---|:---:|:---:|
| $E_0$ (pu):  |  $(@bind E₀₂ NumberField(0.5:0.01:1.5, default=1)) | $(@bind E₀₁ NumberField(0.5:0.01:1.5, default=1)) |
| AVR (%): |  $(@bind sᵤ₂ NumberField(1:0.1:20, default=10)) | $(@bind sᵤ₁ NumberField(1:0.1:20, default=10))  |
	
|  Carga reativa total (pu) | Atuação simultânea AVR* |
|:---:|:---:|
| $Q_t:$ $(@bind Qₜ Slider(0:0.1:2, default=1,show_value=true)) | $(@bind ΔU₀ Slider(-1:0.01:1, default=0)) |
\* AVR: de _automatic voltage regulator_
"""
end

# ╔═╡ df1a9b5c-4e6c-4539-a866-4c106f9644d1


# ╔═╡ 70acba6e-ae13-4260-b85c-c9bf725618e5
md"""
## Repartição de carga entre alternadores
"""

# ╔═╡ 0bf7a852-74fc-479d-a4b8-34693cf082fe
md"""
Os gráficos seguintes, para além de ilustrarem a regulação da frequência e da tensão da rede elétrica isolada, permitem o controlo independente de cada regulador, possibilitando alterar a repartição de carga entre os alternadores.

Para modificar a repartição de carga ativa/reativa entre os alternadores, os respetivos reguladores velocidade/tensão devem ser ajustados de forma inversa e complementar, de modo a manter a frequência/tensão aproximadamente constante. 
"""

# ╔═╡ b59a030a-12a0-4721-9855-c1b13dea545c


# ╔═╡ 95460c65-0ad0-4345-9e89-e4a32d7e5608
md"""
### Cargas ativas, $f=\rm{f}$$(P_1, P_2)\quad\quad$ $(@bind goRf Button("Reset"))
"""

# ╔═╡ 610e2c1d-717b-4daf-86a2-2baebddbe48c
let goRf
md"""
|  Estatismo | Alternador 2  | Alternador 1  |
|---|:---:|:---:|
| $f_0$ (Hz):  |  $(@bind f₀₄ NumberField(30:1:70, default=50)) | $(@bind f₀₃ NumberField(30:1:70, default=50)) |
| Reg. turbina (%): |  $(@bind sₚ₄ NumberField(0.1:0.1:30, default=10)) | $(@bind sₚ₃ NumberField(0.1:0.1:30, default=10))  |

|  Carga ativa total (pu) | Pot. mecânica 2 | Pot. mecânica 1 |
|:---:|:---:|:---:|
| $P_t:$ $(@bind Pᵀ Slider(0:0.1:2, default=1,show_value=true)) | $(@bind Δf₀₄ Slider(-10:0.001:10, default=0)) | $(@bind Δf₀₃ Slider(-10:0.001:10, default=0)) |
"""
end

# ╔═╡ 394bd374-6ff0-411e-bf96-d844554a5e12


# ╔═╡ c7c8459e-83c3-45a9-8b8a-ad14be941dbf
md"""
### Cargas reativas, , $U=\rm{f}$$(Q_1, Q_2)\quad\quad$ $(@bind goRU Button("Reset"))
"""

# ╔═╡ 134799ac-b3cb-40a3-ab9c-ef78d79b140f
let goRU
md"""
|  Estatismo | Alternador 2  | Alternador 1  |
|---|:---:|:---:|
| $E_0$ (pu):  |  $(@bind E₀₄ NumberField(0.5:0.01:1.5, default=1)) | $(@bind E₀₃ NumberField(0.5:0.01:1.5, default=1)) |
| AVR (%): |  $(@bind sᵤ₄ NumberField(1:0.1:20, default=10)) | $(@bind sᵤ₃ NumberField(1:0.1:20, default=10))  |
	
|  Carga reativa total (pu) | AVR 2 | AVR 1 |
|:---:|:---:|:---:|
| $Q_t:$ $(@bind Qᵀ Slider(0:0.1:2, default=1,show_value=true)) | $(@bind ΔU₀₄ Slider(-1:0.001:1, default=0)) | $(@bind ΔU₀₃ Slider(-1:0.001:1, default=0)) |
"""
end

# ╔═╡ 9e308608-d32c-4917-b869-384a2a00104f


# ╔═╡ 1524fb6b-c81b-49e1-a569-9e840ca5c5dc


# ╔═╡ 866d50e6-e827-4ddd-a28e-71aa9032b716
md"""
# Cálculos (ignorar esta secção e subsecções)
"""

# ╔═╡ 1bda4fdf-8b1f-4a05-9d76-afd97a7084f0
md"""
!!! warning "Informação"

	Os cálculos relativos à definição das características de $f=\rm{f}$$(P)$ e de $U=\rm{f}$$(Q)$ de cada alternador, à interseção das mesmas com as cargas ativa e reativa totais, $P_t$ e $Q_t$, bem como os valores de frequência e de tensão resultantes, $f$ e $U$, do funcionamento em paralelo para uma dada carga presente na rede isolada, estão fora do âmbito da unidade curricular de Máquinas Elétricas $\rm{II}$.

	O objetivo fundamental é compreender os mecanismos de atuação em alternadores síncronos trifásicos, designadamente como manter a frequência e a tensão da rede isolada constantes e como alterar a repartição de carga entre os alternadores.
"""

# ╔═╡ 00898e51-080e-4e87-85c0-e9ea1c9dd4c1
Foldable("Listagem das grandezas principais utilizadas:",md"

-  $$f, f'$$: frequências da rede elétrica isolada antes e depois da regulação, (Hz) ;\
-  $$P_t$$: potência ativa total, (pu);\
-  $$P_1, P_2$$: potências ativas dos alternadores 1 e 2, (pu);\
-  $$P_1', P_2'$$: potências ativas dos alternadores 1 e 2 após alteração da repartição de carga, (pu);\
-  $$U, U'G$$: tensões da rede elétrica isolada antes e depois da regulação, (pu)\
-  $$Q_t$$: potência reativa total, (pu)\
-  $$Q_1, Q_2$$: potências reativas dos alternadores 1 e 2, (pu);\
-  $$Q_1', Q_2'$$: potências reativas dos alternadores 1 e 2 após alteração da repartição de carga, (pu);\
-  $$s_{px}$$: declive do regulador de velocidade da turbina (estatismo), (%);\
-  $$f_{0x}$$: frequência de vazio do alternador, (Hz);\
-  $$\Delta f_{0x}$$:  Variação na regulação de frequência, (Hz);\
-  $$s_{ux}$$: declive do regulador de tensão do alternador (estatismo), (%);\
-  $$E_{0x}$$: força eletromotriz de vazio do alternador, (pu);\
-  $$\Delta U_{0x}$$:  Variação na regulação de tensão, (pu).\

")

# ╔═╡ 9bd7bc63-abcb-4cc3-9d1c-0db0621abbe8


# ╔═╡ 810f5c52-50b7-491d-8d43-e8c423e1f501
Foldable("Principais equações utilizadas:",md"

Estatismo do regulador de velocidade da turbina:

$f=f_0-s_p P$

A potência ativa produzida pelo alternador:

$P=\frac{f_0-f}{s_p}$

A frequência do paralelo de alternadores, $f$, é encontrada fazendo:

$P_t=P_1+P_2=\frac{f_{01}-f}{s_{p1}} + \frac{f_{02}-f}{s_{p2}}$

O que resulta:

$f=\frac{s_{p1}f_{02}+s_{p2}f_{01}-s_{p1}s_{p2}P_t}{s_{p1}+s_{p2}}$

\
Estatismo do regulador de tensão do alternador:

$U=E_0-s_u Q$

A potência reativa do alternador:

$Q=\frac{E_0-U}{s_u}$

A tensão do paralelo de alternadores, $U$, é encontrada fazendo:

$Q_t=Q_1+Q_2=\frac{E_{01}-U}{s_{u1}} + \frac{E_{02}-U}{s_{u2}}$

O que resulta:

$U=\frac{s_{u1}E_{02}+s_{u2}E_{01}-s_{u1}s_{u2}Q_t}{s_{u1}+s_{u2}}$

")

# ╔═╡ 35383e93-7b89-4852-84d9-ace4909368ea


# ╔═╡ 1a488c4d-b73d-4097-9c31-8eed674cb22c
md"""
## Máq. síncrona ligada à rede elétrica
"""

# ╔═╡ 2247e1f0-105e-482b-9298-5d32a96225e9
Pₐₗₜ = (f₀ - 50)*2/sₚ; # P(f=50Hz)

# ╔═╡ 7773a1bd-be10-42d6-992d-f1ea67aead4e
if f₀ < 50
	Power = Pₐₗₜ:0.1:1
else
	Power = 0:0.1:1
end;

# ╔═╡ a97d2696-8616-441b-a536-6bf0d27befa2
fₐₗₜ = f₀ .- Power*sₚ*0.5; # estatismo P

# ╔═╡ d0d09f83-a8d7-4f40-b3b6-9585c098f09a
if Pₐₗₜ > 0
	modeP="alternador:"
elseif Pₐₗₜ < 0
	modeP="motor:"
elseif Pₐₗₜ == 0 && E₀ != 1
		modeP="compensador:"	
else
	modeP=""
end;

# ╔═╡ bb56acae-7dca-4000-90d1-2adc441676e3
Qₐₗₜ = (E₀ - 1)*100/sᵢ; # Q(U=1 pu)

# ╔═╡ c4de022d-f5ce-4f93-803b-c40739c1acf1
if E₀ < 1
	Reactive = Qₐₗₜ:0.1:1
else
	Reactive = 0:0.1:1
end;

# ╔═╡ c00983db-f555-498d-93b7-142367b25ae6
Uₐₗₜ = E₀ .- Reactive*sᵢ*0.01; # estatismo Q

# ╔═╡ 7a7f5ae9-adb5-4ae6-ae73-4e83ce709b8d
if E₀ > 1 && f₀ > 50
	modeQ="indutivo:"
elseif E₀ < 1 && f₀ > 50
	modeQ="capacitivo:"
elseif E₀ > 1 && f₀ < 50
	modeQ="capacitivo:"
elseif E₀ < 1 && f₀ < 50
	modeQ="indutivo:"
elseif f₀ == 50	&& E₀ < 1  #(motor em vazio)
	modeQ="indutivo:"
elseif f₀ == 50	&& E₀ > 1  #(motor em vazio)
	modeQ="capacitivo:"	
else
	modeQ=""
end;

# ╔═╡ 5322c81f-b04f-46e8-9c07-56238a02d889
begin
	#f(P):
	h1=plot([-1, Pₐₗₜ], [50, 50], label="rede elétrica", lw=2, ylim=[0, 60], xlim=[-1, 1], 
		xlabel="\$ P\$ (pu)", ylabel="\$f\$ (Hz)", 
		xticks=(-1:0.25:1, [1 0.75 0.5 0.25 0 0.25 0.5 0.75 1.0]))
	plot!(Power, fₐₗₜ, lw=2, label="máq. síncrona", size=[400,300], framestyle=:zerolines)
	plot!([Pₐₗₜ], st=:vline, ls=:dash, lc=:red, label=false, legend=:bottomleft)
	annotate!(Pₐₗₜ, 25, text(" $(modeP) \$P=\$ $(round(abs(Pₐₗₜ), digits=1)) pu",:red, :center, 9))

	#U(Q):
	h2=plot([-1, Qₐₗₜ], [1, 1], label="rede elétrica", lw=2, ylim=[0, 1.25], xlim=[-1, 1], 
		xlabel="\$ Q\$ (pu)", ylabel="\$U\$ (pu)", 
		xticks=(-1:0.25:1, [1 0.75 0.5 0.25 0 0.25 0.5 0.75 1.0]))
	plot!(Reactive, Uₐₗₜ, lw=2, label="máq. síncrona", size=[400,300], framestyle=:zerolines)
	plot!([Qₐₗₜ], st=:vline, ls=:dash, lc=:red, label=false, legend=:bottomleft)
	annotate!(Qₐₗₜ, 0.5, text(" $(modeQ) \$Q=\$ $(round(abs(Qₐₗₜ), digits=1)) pu",:red, :center, 9))
plot(h1,h2, size=(800, 450))
	
end

# ╔═╡ 8a0795d5-a5e3-48d3-9325-c19e3b2170d0


# ╔═╡ 94b6e3ae-30a3-4719-acac-dd15e48207ec
md"""
## Paralelo de alternadores síncronos
"""

# ╔═╡ db7fa0c4-f55a-4ef2-b8d7-1063af82f459
md"""
### Regulação de frequência e tensão
"""

# ╔═╡ 350f0bdb-ac51-475e-a0de-c6fc64b56032
md"""
#### Regulação de frequência
"""

# ╔═╡ 46b6eadd-586d-4cda-8e45-f04ddc07fb30
fₙ=50;

# ╔═╡ e0a6ef0f-a6b2-4be7-abfc-7f21503a5820
P=0:0.1:1;

# ╔═╡ 13df20dc-8ff1-4395-aae9-a7f06f50eb49
f₁ = f₀₁ .- P*sₚ₁*0.5;

# ╔═╡ 0eaa081f-4499-4e53-bfb8-9bd84b69a235
f₁ʼ = (f₀₁+Δf₀) .- P*sₚ₁*0.5;

# ╔═╡ ee768c39-18ff-414f-afd0-afa52317c857
f₂ = f₀₂ .- P*sₚ₂*0.5;

# ╔═╡ cd9febd3-904f-4bf7-bd11-5acbd5add81a
f₂ʼ = (f₀₂+Δf₀) .- P*sₚ₂*0.5;

# ╔═╡ d23f83ff-3ffb-416d-bdbe-1ebffc49204e
f = (sₚ₁*f₀₂ + sₚ₂*f₀₁ - 0.5*Pₜ*sₚ₁*sₚ₂)/(sₚ₁ + sₚ₂);

# ╔═╡ e29373e5-525e-42f2-bed7-1dce3878b330
fʼ = (sₚ₁*(f₀₂+Δf₀) + sₚ₂*(f₀₁+Δf₀) - 0.5*Pₜ*sₚ₁*sₚ₂)/(sₚ₁ + sₚ₂);

# ╔═╡ 1f8863ca-836f-4660-8f84-7a7a4bc6c926
md"""
Note-se que o valor de $$f=$$ $(round(f, digits=2)) Hz, representa a frequência de funcionamento da rede isolada, que resulta do encontro da potência ativa total requerida pela carga, $$P_t=$$ $(round(Pₜ, digits=2)) (pu), com as potências fornecidas pelos alternadores 1 e 2 de modo a garantir o equilíbrio entre produção e consumo: $$P_t=P_1+P_2$$. 

As funções $f=\rm{f}$$(P)$ representadas a tracejado mostram o resultado da atuação nos reguladores de velocidade das turbinas, permitindo regular a frequência de funcionamento da rede isolada para $$f'=$$ $(round(fʼ, digits=2)) Hz.
"""

# ╔═╡ b2b58c55-e297-4c4e-b1b3-f31056161dff
P₁=(f₀₁-f)*2/sₚ₁; P₂=(f₀₂-f)*2/sₚ₂;

# ╔═╡ 82ab157a-13ca-466a-8ad6-33993b552e8f
begin
	plot(P, f₁,  xlim=[-1,1], ylim=[0,60], framestyle=:zerolines, lc=:red, lw=2, label=false,
	xticks=(-1:0.2:1, [1.0 0.8 0.6 0.4 0.2 0.0 0.2 0.4 0.6 0.8 1.0]))
	plot!(-P,f₂, lc=:blue, lw=2, label=false, ylabel=" \$f\$ (Hz)",
		xlabel="\$P_2\$ (pu)                                           \$P_1\$ (pu) ")

	plot!(P, f₁ʼ, lc=:red, lw=2, linestyle=:dash, label=false, size=[700, 400])
	plot!(-P, f₂ʼ, lc=:blue, lw=2, linestyle=:dash, label=false)

	plot!([f], seriestype = :hline,	linestyle=:dash, linecolor=:green, label=:none)
	annotate!(0.07, 20, text(" \$f=\$ $(round(f, digits=2)) Hz", :green, :center, 11))
	annotate!(0.07, 30, text(" \$f'=\$ $(round(fʼ, digits=2)) Hz", :purple, :center, 11))
	
	plot!([-P₂, P₁],  seriestype = :vline, linestyle=:dash, linecolor=:green, label=:none)
	annotate!(-P₂, 25, text(" \$P_2=\$ $(round(P₂, digits=2)) pu", :green, :center, 11))
	annotate!(P₁, 15, text(" \$P_1=\$ $(round(P₁, digits=2)) pu", :green, :center, 11))

	plot!([(-P₂,7), (P₁, 7)], arrow = arrow(:closed, 0.1, :both), color = :green; label=:none)
	annotate!((P₁-P₂)/2, 9, text(" \$P_t=\$ $(round(Pₜ, digits=2)) pu", :green, :center, 11))
	
	plot!([fₙ],  seriestype = :hline, linestyle=:dashdot, linecolor=:black, label=:none)
end

# ╔═╡ 3ac1b00e-f25b-432c-a5fd-a9ed994cd0a5
P₁ʼ=(f₀₁+Δf₀-fʼ)*2/sₚ₁; P₂ʼ=(f₀₂+Δf₀-fʼ)*2/sₚ₂;

# ╔═╡ 632135c0-966b-444d-a670-c55439794e46
(Pₜ, P₁, P₂, P₁ + P₂), (Pₜ, P₁ʼ, P₂ʼ, P₁ʼ + P₂ʼ), (f, fʼ)

# ╔═╡ eecc768d-f3a7-4415-9981-f668cb9370bf


# ╔═╡ 12b3e43f-b97c-4c5b-9f7f-c008c107d5cb
md"""
#### Regulação de tensão
"""

# ╔═╡ 8e141c56-cf6c-459f-97d4-7de917f64432
Uₙ=1;

# ╔═╡ 172db7ff-7a72-45c4-99fb-7a122996728c
Q=0:0.1:1;

# ╔═╡ 7ffba3ce-21cb-4543-8a2d-61e6f87f6c9b
U₁ = E₀₁ .- Q*sᵤ₁*0.01;

# ╔═╡ 1c28b4ee-7d20-4471-a703-0c8d267b6386
U₁ʼ = (E₀₁+ΔU₀) .- Q*sᵤ₁*0.01;

# ╔═╡ da488f81-1516-4034-9a23-3d84f5342617
U₂ = E₀₂ .- Q*sᵤ₂*0.01;

# ╔═╡ 2b262fd9-a25d-49df-99e9-3a3290a59d66
U₂ʼ = (E₀₂+ΔU₀) .- Q*sᵤ₂*0.01;

# ╔═╡ 4a404857-3667-43c0-bc77-1c0e43956520
U = (sᵤ₁*E₀₂ + sᵤ₂*E₀₁ - 0.01*Qₜ*sᵤ₁*sᵤ₂)/(sᵤ₁ + sᵤ₂);

# ╔═╡ ba2d01cd-232f-4fea-b9e7-bcfe3206b336
Uʼ = (sᵤ₁*(E₀₂+ΔU₀) + sᵤ₂*(E₀₁+ΔU₀) - 0.01*Qₜ*sᵤ₁*sᵤ₂)/(sᵤ₁ + sᵤ₂);

# ╔═╡ 0bc74e86-0e0d-4cc5-9a21-45c9a526ef67
md"""
Note-se que o valor de $$U=$$ $(round(U, digits=2)) pu, representa a tensão de funcionamento da rede isolada, que resulta do encontro da potência reativa total requerida pela carga, $$Q_t=$$ $(round(Qₜ, digits=2)) (pu), com as potências fornecidas pelos alternadores 1 e 2 de modo que: $$Q_t=Q_1+Q_2$$. 

As funções $U=\rm{f}$$(Q)$ representadas a tracejado, mostram o resultado da atuação nos reguladores de tensão dos alternadores, permitindo regular a tensão de funcionamento da rede isolada para $$U'=$$ $(round(Uʼ, digits=2)) pu.
"""

# ╔═╡ 66f12e98-d090-4243-9073-93adc8176e9c
Q₁=(E₀₁-U)*100/sᵤ₁; Q₂=(E₀₂-U)*100/sᵤ₂;

# ╔═╡ 27090b64-5638-4adf-b3f0-d93c83d15283
begin
	plot(Q, U₁, xlim=[-1,1], ylim=[0,1.25], framestyle=:zerolines, lc=:red, lw=2, label=false,
	xticks=(-1:0.2:1, [1.0 0.8 0.6 0.4 0.2 0.0 0.2 0.4 0.6 0.8 1.0]))
	plot!(-Q,U₂, lc=:blue, lw=2, label=false, ylabel=" \$U\$ (pu)",
		xlabel="\$Q_2\$ (pu)                                           \$Q_1\$ (pu) ")

	plot!(Q, U₁ʼ, lc=:red, lw=2, linestyle=:dash, label=false, size=[700, 400])
	plot!(-Q, U₂ʼ, lc=:blue, lw=2, linestyle=:dash, label=false)

	plot!([U], seriestype = :hline,	linestyle=:dash, linecolor=:green, label=:none)
	annotate!(0.07, 0.4, text(" \$U=\$ $(round(U, digits=2)) pu", :green, :center, 11))
	annotate!(0.07, 0.6, text(" \$U'=\$ $(round(Uʼ, digits=2)) pu", :purple, :center, 11))
	
	plot!([-Q₂, Q₁],  seriestype = :vline, linestyle=:dash, linecolor=:green, label=:none)
	annotate!(-Q₂, 0.5, text(" \$Q_2=\$ $(round(Q₂, digits=2)) pu", :green, :center, 11))
	annotate!(Q₁, 0.3, text(" \$Q_1=\$ $(round(Q₁, digits=2)) pu", :green, :center, 11))

	plot!([(-Q₂,0.15), (Q₁, 0.15)], arrow = arrow(:closed, 0.1, :both), color = :green; label=:none)
	annotate!((Q₁-Q₂)/2, 0.19, text(" \$Q_t=\$ $(round(Qₜ, digits=2)) pu", :green, :center, 11))
	
	plot!([Uₙ],  seriestype = :hline, linestyle=:dashdot, linecolor=:black, label=:none)
end

# ╔═╡ 401cd7ab-6a06-4dbb-8b36-c9ffefe14bb0
Q₁ʼ=(E₀₁+ΔU₀-Uʼ)*100/sᵤ₁; Q₂ʼ=(E₀₂+ΔU₀-Uʼ)*100/sᵤ₂;

# ╔═╡ b0200b11-609d-4cb7-b8b2-56dd284cf996
(Qₜ, Q₁, Q₂, Q₁ + Q₂), (Qₜ, Q₁ʼ, Q₂ʼ, Q₁ʼ + Q₂ʼ), (U, Uʼ)

# ╔═╡ 0a23bd0a-52ac-4b9c-b33f-a7b54c60da65


# ╔═╡ fa88c116-03eb-477c-9c2f-83a83da27b1c
md"""
### Repartição de carga entre alternadores
"""

# ╔═╡ c0cb8506-a8e5-42ef-8372-dc952da9f5cf
md"""
#### Cargas ativas
"""

# ╔═╡ ee2e051c-e9f3-48ec-9821-b8ad1b2ff90f
f₃ = f₀₃ .- P*sₚ₃*0.5;

# ╔═╡ 3efa96ab-2f37-4992-a746-93614358f65a
f₃ʼ = (f₀₃+Δf₀₃) .- P*sₚ₃*0.5;

# ╔═╡ e6aef6d2-0e34-4ef7-bed9-84d8d3631f16
f₄ = f₀₄ .- P*sₚ₄*0.5;

# ╔═╡ f5af2bb9-76b7-4eba-99bd-4d94c9eaa039
f₄ʼ = (f₀₄+Δf₀₄) .- P*sₚ₄*0.5;

# ╔═╡ 930436b5-61b8-4a20-a314-8c14729422fd
fᵣ = (sₚ₃*f₀₄ + sₚ₄*f₀₃ - 0.5*Pᵀ*sₚ₃*sₚ₄)/(sₚ₃ + sₚ₄);

# ╔═╡ e37f152b-49d6-4b16-b6e6-e4205b9baeef
fᵣʼ = (sₚ₃*(f₀₄+Δf₀₄) + sₚ₄*(f₀₃+Δf₀₃) - 0.5*Pᵀ*sₚ₃*sₚ₄)/(sₚ₃ + sₚ₄);

# ╔═╡ 4c320ce6-9088-4f2c-807f-3ea11867b7e3
P₃=(f₀₃-fᵣ)*2/sₚ₃; P₄=(f₀₄-fᵣ)*2/sₚ₄;

# ╔═╡ a3aa6282-c81e-4ca3-b481-250fa432224f
P₃ʼ=(f₀₃+Δf₀₃-50)*2/sₚ₃; P₄ʼ=(f₀₄+Δf₀₄-50)*2/sₚ₄;

# ╔═╡ 16890006-2486-4572-b685-8fe7bed7f56b
begin
	plot(P, f₃,  xlim=[-1,1], ylim=[0,60], framestyle=:zerolines, lc=:red, lw=2, label=false,
	xticks=(-1:0.2:1, [1.0 0.8 0.6 0.4 0.2 0.0 0.2 0.4 0.6 0.8 1.0]))
	plot!(-P,f₄, lc=:blue, lw=2, label=false, ylabel=" \$f\$ (Hz)",
		xlabel="\$P_2\$ (pu)                                           \$P_1\$ (pu) ")

	plot!(P, f₃ʼ, lc=:red, lw=2, linestyle=:dash, label=false, size=[700, 400])
	plot!(-P, f₄ʼ, lc=:blue, lw=2, linestyle=:dash, label=false)

	plot!([fᵣ], seriestype = :hline,	linestyle=:dash, linecolor=:green, label=:none)
	annotate!(0.07, 20, text(" \$f=\$ $(round(fᵣ, digits=2)) Hz", :green, :center, 11))
	annotate!(0.07, 30, text(" \$f'=\$ $(round(fᵣʼ, digits=2)) Hz", :purple, :center, 11))
	
	plot!([-P₄, P₃],  seriestype = :vline, linestyle=:dash, linecolor=:green, label=:none)
	annotate!(-P₄, 25, text(" \$P_2=\$ $(round(P₄, digits=2)) pu", :green, :center, 11))
	annotate!(P₃, 15, text(" \$P_1=\$ $(round(P₃, digits=2)) pu", :green, :center, 11))

	plot!([(-P₄,10), (P₃, 10)], arrow = arrow(:closed, 0.1, :both), color = :green; label=:none)
	annotate!((P₃-P₄)/2, 12, text(" \$P_t=\$ $(round(Pᵀ, digits=2)) pu", :green, :center, 11))
	
	plot!([fₙ],  seriestype = :hline, linestyle=:dashdot, linecolor=:black, label=:none)

	plot!([-P₄ʼ, P₃ʼ],  seriestype = :vline, linestyle=:dash, linecolor=:purple, label=:none)
	annotate!(-P₄ʼ, 35, text(" \$P_2'=\$ $(round(P₄ʼ, digits=2)) pu", :purple, :center, 11))
	annotate!(P₃ʼ, 35, text(" \$P_1'=\$ $(round(P₃ʼ, digits=2)) pu", :purple, :center, 11))
	
	plot!([(-P₄ʼ,4), (P₃ʼ, 4)], arrow = arrow(:closed, 0.1, :both), color = :purple; label=:none)
	annotate!((P₃ʼ-P₄ʼ)/2, 6, text(" \$P_t=\$ $(round(Pᵀ, digits=2)) pu", :purple, :center, 11))
end

# ╔═╡ 3c3bcfc4-7734-4517-840d-58618f3e6401
(Pᵀ, P₃, P₄, P₃ + P₄), (Pᵀ, P₃ʼ, P₄ʼ, P₃ʼ + P₄ʼ), (fᵣ, fᵣʼ)

# ╔═╡ 84ebc8fa-e8e1-4681-b1f1-4d2ad815dd19


# ╔═╡ d986ca61-12b3-4d69-80ca-e39cf203bd47
md"""
#### Cargas reativas
"""

# ╔═╡ 5bbf68bf-f875-4bc6-b0bf-14c929ba10a7
U₃ = E₀₃ .- Q*sᵤ₃*0.01;

# ╔═╡ 6ee0e218-9d1f-4c42-93bb-d35b3d515284
U₃ʼ = (E₀₃+ΔU₀₃) .- Q*sᵤ₃*0.01;

# ╔═╡ 76248992-0240-4856-a7b1-b49cf1de3e8d
U₄ = E₀₄ .- Q*sᵤ₄*0.01;

# ╔═╡ 35ab6d04-9654-4817-8b67-deade695da39
U₄ʼ = (E₀₄+ΔU₀₄) .- Q*sᵤ₄*0.01;

# ╔═╡ 5ba14cc9-01c2-40e6-9660-a08d84e4d9b2
Uᵣ = (sᵤ₃*E₀₄ + sᵤ₄*E₀₃ - 0.01*Qᵀ*sᵤ₃*sᵤ₄)/(sᵤ₃ + sᵤ₄);

# ╔═╡ 0dfe81fa-e6ba-4160-a909-47a89e0047d0
Uᵣʼ = (sᵤ₃*(E₀₄+ΔU₀₄) + sᵤ₄*(E₀₃+ΔU₀₃) - 0.01*Qᵀ*sᵤ₃*sᵤ₄)/(sᵤ₃ + sᵤ₄);

# ╔═╡ 08b9a33f-9cb4-45d4-8450-25d11c620776
Q₃=(E₀₃-Uᵣ)*100/sᵤ₃; Q₄=(E₀₄-Uᵣ)*100/sᵤ₄;

# ╔═╡ 2904acca-27d9-4152-83c2-a8eb3e03c824
Q₃ʼ=(E₀₃+ΔU₀₃-1)*100/sᵤ₃; Q₄ʼ=(E₀₄+ΔU₀₄-1)*100/sᵤ₄;

# ╔═╡ 0b8c48ee-e28a-48e3-ad13-cabafee57802
begin
	plot(Q, U₃, xlim=[-1,1], ylim=[0,1.25], framestyle=:zerolines, lc=:red, lw=2, label=false,
	xticks=(-1:0.2:1, [1.0 0.8 0.6 0.4 0.2 0.0 0.2 0.4 0.6 0.8 1.0]))
	plot!(-Q,U₄, lc=:blue, lw=2, label=false, ylabel=" \$U\$ (pu)",
		xlabel="\$Q_2\$ (pu)                                           \$Q_1\$ (pu) ")

	plot!(Q, U₃ʼ, lc=:red, lw=2, linestyle=:dash, label=false, size=[700, 400])
	plot!(-Q, U₄ʼ, lc=:blue, lw=2, linestyle=:dash, label=false)

	plot!([Uᵣ], seriestype = :hline,	linestyle=:dash, linecolor=:green, label=:none)
	annotate!(0.07, 0.4, text(" \$U=\$ $(round(Uᵣ, digits=2)) pu", :green, :center, 11))
	annotate!(0.07, 0.6, text(" \$U'=\$ $(round(Uᵣʼ, digits=2)) pu", :purple, :center, 11))
	
	plot!([-Q₄, Q₃],  seriestype = :vline, linestyle=:dash, linecolor=:green, label=:none)
	annotate!(-Q₄, 0.5, text(" \$Q_2=\$ $(round(Q₄, digits=2)) pu", :green, :center, 11))
	annotate!(Q₃, 0.3, text(" \$Q_1=\$ $(round(Q₃, digits=2)) pu", :green, :center, 11))

	plot!([(-Q₄,0.15), (Q₃, 0.15)], arrow = arrow(:closed, 0.1, :both), color = :green; label=:none)
	annotate!((Q₃-Q₄)/2, 0.19, text(" \$Q_t=\$ $(round(Qᵀ, digits=2)) pu", :green, :center, 11))
	
	plot!([Uₙ],  seriestype = :hline, linestyle=:dashdot, linecolor=:black, label=:none)
	#plot!([Uᵣʼ],  seriestype = :hline, linestyle=:dash, linecolor=:purple, label=:none)

	plot!([-Q₄ʼ, Q₃ʼ],  seriestype = :vline, linestyle=:dash, linecolor=:purple, label=:none)
	annotate!(-Q₄ʼ, 0.7, text(" \$Q_2'=\$ $(round(Q₄ʼ, digits=2)) pu", :purple, :center, 11))
	annotate!(Q₃ʼ, 0.7, text(" \$Q_1'=\$ $(round(Q₃ʼ, digits=2)) pu", :purple, :center, 11))
	
	plot!([(-Q₄ʼ,0.08), (Q₃ʼ, 0.08)], arrow = arrow(:closed, 0.1, :both), color = :purple; label=:none)
	annotate!((Q₃ʼ-Q₄ʼ)/2, 0.125, text(" \$Q_t=\$ $(round(Qᵀ, digits=2)) pu", :purple, :center, 11))
end

# ╔═╡ f9bfc461-cbbd-479f-829d-991bfa6a086b
(Qᵀ, Q₃, Q₄, Q₃ + Q₄), (Qᵀ, Q₃ʼ, Q₄ʼ, Q₃ʼ + Q₄ʼ), (Uᵣ, Uᵣʼ)

# ╔═╡ 40fc37d4-5650-4148-9d55-e8f47023d8cb
# to adjust the notebook margins and used font-family/size on text content
html"""<style>
@media screen {
	main {
		margin: auto;
		max-width: 1920px;
		padding-left: 5%;
		padding-right: 25.9%; 
		}
	}
pluto-output {
    font-family: system-ui;
	font-size:  100%
}
</style>
"""

# ╔═╡ 115fb585-3521-45d1-bfef-c14e9023491d
md"""
# _Notebook_
"""

# ╔═╡ 61071afc-5f68-4362-afe8-7558b8a7cbb3
begin
	version=VERSION
	md"""
*Notebook* desenvolvido em `Julia` versão $(version).
"""
end

# ╔═╡ 6ac92bd1-0b05-461e-b123-7b8d483945c1
md"""
!!! info "Informação"
	No índice deste *notebook*, os tópicos assinalados com "💻" requerem a participação do estudante.
"""

# ╔═╡ 3f4d7f27-2d4a-46ed-8e8b-62d68afd97dd
TableOfContents(title="Índice", depth=4)

# ╔═╡ c92581e1-a4c4-46c9-9cb4-ee7045d9d634
md"""
|  |  |
|:--:|:--|
|  | This notebook, [ParallelSynAlt.jl](https://ricardo-luis.github.io/me-2/ParallelSynAlt.html), is part of the collection "[_Notebooks_ Computacionais Aplicados a Máquinas Elétricas II](https://ricardo-luis.github.io/me-2/)" by Ricardo Luís. |
| **Terms of Use** | All narrative and visual content is shared under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)), while the Julia code snippets are released under the [MIT License](https://www.tldrlegal.com/license/mit-license).|
|  | $©$ 2022-2025 [Ricardo Luís](https://ricardo-luis.github.io/) |
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Plots = "~1.40.17"
PlutoTeachingTools = "~0.2.15"
PlutoUI = "~0.7.69"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.6"
manifest_format = "2.0"
project_hash = "e36c37af0f15eade5f5a9563f0dea37e9fff4ca8"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
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

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "fde3bf89aead2e723284a8ff9cdf5b551ed700e8"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.5+0"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "5ac098a7c8660e217ffac31dc2af0964a8c3182a"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "2.0.0"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "962834c22b66e32aa10f7611c08c8ca4e20749a9"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.8"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "a656525c8b46aa6a1c76891552ed5381bb32ae7b"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.30.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "8b3b6f87ce8f65a2b4f857528fd8d70086cd72b1"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.11.0"

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "37ea44092930b1811e666c3bc38065d7d87fcc74"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.1"

[[deps.Compiler]]
git-tree-sha1 = "382d79bfe72a406294faca39ef0c3cef6e6ce1f1"
uuid = "807dbc54-b67e-4c79-8afb-eafe4df6f2e1"
version = "0.1.1"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "d9d26935a0bcffc87d2613ce14c527c99fc543fd"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.5.0"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["OrderedCollections"]
git-tree-sha1 = "76b3b7c3925d943edf158ddb7f693ba54eb297a5"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.19.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "473e9afc9cf30814eb67ffa5f2db7df82c3ad9fd"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.16.2+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a4be429317c42cfae6a7fc03c31bad1970c310d"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+1"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "d36f682e590a83d63d1c7dbd287573764682d12a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.11"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d55dffd9ae73ff72f1c0482454dcf2ec6c6c4a63"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.6.5+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "83dc665d0312b41367b7263e8a4d172eac1897f4"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.4"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "3a948313e7a41eb1db7a1e733e6335f17b4ab3c4"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "7.1.1+0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "301b5d5d731a0654825f1f2e906990f7141a106b"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.16.0+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "2c5512e11c791d1baed2049c5652441b28fc6a31"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7a214fdac5ed5f59a22c2d9a885a16da1c74bbc7"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.17+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "fcb0584ff34e25155876418979d4c8971243bb89"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.4.0+2"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Preferences", "Printf", "Qt6Wayland_jll", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "p7zip_jll"]
git-tree-sha1 = "1828eb7275491981fa5f1752a5e126e8f26f8741"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.17"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "27299071cc29e409488ada41ec7643e0ab19091f"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.17+0"

[[deps.GettextRuntime_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll"]
git-tree-sha1 = "45288942190db7c5f760f59c04495064eedf9340"
uuid = "b0724c58-0f36-5564-988d-3bb0596ebc4a"
version = "0.22.4+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "GettextRuntime_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "35fbd0cefb04a516104b8e183ce0df11b70a3f1a"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.84.3+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a6dbda1fd736d60cc477d99f2e7a042acfa46e8"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.15+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "ed5e9c58612c4e081aecdb6e1a479e18462e041e"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.17"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "f923f9a774fcf3f5cb761bfa43aeadd689714813"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.5.1+0"

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
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "e2222959fbc6c19554dc15174c81bf7bf3aa691c"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.4"

[[deps.JLFzf]]
deps = ["REPL", "Random", "fzf_jll"]
git-tree-sha1 = "82f7acdc599b65e0f8ccd270ffa1467c21cb647b"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.11"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "0533e564aae234aff59ab625543145446d8b6ec2"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "eac1206917768cb54957c65a615460d87b455fc1"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.1.1+0"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "e09121f4c523d8d8d9226acbed9cb66df515fcf2"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.10.4"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "059aabebaa7c82ccb853dd4a0ee9d17796f7e1bc"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.3+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aaafe88dccbd957a8d82f7d05be9b69172e0cee3"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "4.0.1+0"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "eb62a3deb62fc6d8822c0c4bef73e4412419c5d8"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.8+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1c602b1127f4751facb671441ca72715cc95938a"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.3+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "4f34eaabe49ecb3fb0d58d6015e32fd31a733199"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.8"

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
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c8da7e6a91781c41a863611c7e966098d783c57a"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.4.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "d36c21b9e7c172a44a10484125024495e2625ac0"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.1+1"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a31572773ac1b745e0343fe5e2c8ddda7a37e997"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.41.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "4ab7581296671007fc33f07a721631b8855f4b1d"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.1+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "321ccef73a96ba828cd51f2ab5b9f917fa73945a"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.41.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "13ca9e2586b89836fd20cccf56e57e2b9ae7f38f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.29"

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

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "f02b56007b064fbfddb4c9cd60161b6dd0f40df3"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.1.0"

[[deps.LoweredCodeUtils]]
deps = ["CodeTracking", "Compiler", "JuliaInterpreter"]
git-tree-sha1 = "73b98709ad811a6f81d84e105f4f695c229385ba"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "3.4.3"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "9b8215b1ee9e78a293f99797cd31375471b2bcae"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.3"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6aa4566bb7ae78498a5e68943863fa8b5231b59"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.6+0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.5+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "f1a7e086c677df53e064e0fdd2c9d0b0833e3f6e"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.5.0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "87510f7292a2b21aeff97912b0898f9553cc5c2c"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.1+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c392fc5dd032381919e3b22dd32d6443760ce7ea"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.5.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "275a9a6d85dc86c24d03d1837a0010226a96f540"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.56.3+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7d2f8f21da5db6a806faf7b9b292296da42b2810"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.3"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "db76b1ecd5e9715f3d043cec13b2ec93ce015d53"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.44.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "41031ef3a1be6f5bbbf3e8073f210556daeae5ca"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.3.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "StableRNGs", "Statistics"]
git-tree-sha1 = "3ca9a356cd2e113c420f2c13bea19f8d3fb1cb18"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.3"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "TOML", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "3db9167c618b290a05d4345ca70de6d95304a32a"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.40.17"

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

[[deps.PlutoHooks]]
deps = ["InteractiveUtils", "Markdown", "UUIDs"]
git-tree-sha1 = "072cdf20c9b0507fdd977d7d246d90030609674b"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0774"
version = "0.0.5"

[[deps.PlutoLinks]]
deps = ["FileWatching", "InteractiveUtils", "Markdown", "PlutoHooks", "Revise", "UUIDs"]
git-tree-sha1 = "8f5fa7056e6dcfb23ac5211de38e6c03f6367794"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0420"
version = "0.1.6"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "LaTeXStrings", "Latexify", "Markdown", "PlutoLinks", "PlutoUI", "Random"]
git-tree-sha1 = "5d9ab1a4faf25a62bb9d07ef0003396ac258ef1c"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.2.15"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "2d7662f95eafd3b6c346acdbfc11a762a2256375"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.69"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.PtrArrays]]
git-tree-sha1 = "1d36ef11a9aaf1e8b74dacc6a731dd1de8fd493d"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.3.0"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "eb38d376097f47316fe089fc62cb7c6d85383a52"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.8.2+1"

[[deps.Qt6Declarative_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6ShaderTools_jll"]
git-tree-sha1 = "da7adf145cce0d44e892626e647f9dcbe9cb3e10"
uuid = "629bc702-f1f5-5709-abd5-49b8460ea067"
version = "6.8.2+1"

[[deps.Qt6ShaderTools_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "9eca9fc3fe515d619ce004c83c31ffd3f85c7ccf"
uuid = "ce943373-25bb-56aa-8eca-768745ed7b5a"
version = "6.8.2+1"

[[deps.Qt6Wayland_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6Declarative_jll"]
git-tree-sha1 = "e1d5e16d0f65762396f9ca4644a5f4ddab8d452b"
uuid = "e99dba38-086e-5de3-a5b1-6e4c66e897c3"
version = "6.8.2+1"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.Revise]]
deps = ["CodeTracking", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "20ccb7e2501e9da93fe8450d01aeabf16a5f0c82"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.8.1"

    [deps.Revise.extensions]
    DistributedExt = "Distributed"

    [deps.Revise.weakdeps]
    Distributed = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "9b81b8393e50b7d4e6d0a9f14e192294d3b7c109"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.3.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "f305871d2f381d21527c770d4788c06c097c9bc1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.2.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "64d974c2e6fdf07f8155b5b2ca2ffa9069b608d9"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.2"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.11.0"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "95af145932c2ed859b63329952ce8d633719f091"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.3"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9d72a13a3f4dd3795a195ac5a44d7d6ff5f552ff"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.1"

[[deps.StatsBase]]
deps = ["AliasTables", "DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "2c962245732371acd51700dbb268af311bddd719"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.6"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.7.0+0"

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
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.Tricks]]
git-tree-sha1 = "0fc001395447da85495b7fef1dfae9789fdd6e31"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.11"

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

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "6258d453843c466d84c17a58732dda5deeb8d3af"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.24.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    ForwardDiffExt = "ForwardDiff"
    InverseFunctionsUnitfulExt = "InverseFunctions"
    PrintfExt = "Printf"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"
    Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "af305cc62419f9bd61b6644d19170a4d258c7967"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.7.0"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "96478df35bbc2f3e1e791bc7a3d0eeee559e60e9"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.24.0+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fee71455b0aaa3440dfdd54a9a36ccef829be7d4"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.8.1+0"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a3ea76ee3f4facd7a64684f9af25310825ee3668"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.2+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "9c7ad99c629a44f81e7799eb05ec2746abb5d588"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.6+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "b5899b25d17bf1889d25906fb9deed5da0c15b3b"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.12+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aa1261ebbac3ccc8d16558ae6799524c450ed16b"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.13+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "6c74ca84bbabc18c4547014765d194ff0b4dc9da"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.4+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "52858d64353db33a56e13c341d7bf44cd0d7b309"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.6+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "a4c0ee07ad36bf8bbce1c3bb52d21fb1e0b987fb"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.7+0"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "9caba99d38404b285db8801d5c45ef4f4f425a6d"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "6.0.1+0"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "a376af5c7ae60d29825164db40787f15c80c7c54"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.8.3+0"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll"]
git-tree-sha1 = "a5bc75478d323358a90dc36766f3c99ba7feb024"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.6+0"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "aff463c82a773cb86061bce8d53a0d976854923e"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.5+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "7ed9347888fac59a618302ee38216dd0379c480d"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.12+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXau_jll", "Xorg_libXdmcp_jll"]
git-tree-sha1 = "bfcaf7ec088eaba362093393fe11aa141fa15422"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.1+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "e3150c7400c41e207012b41659591f083f3ef795"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.3+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "c5bf2dad6a03dfef57ea0a170a1fe493601603f2"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.5+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f4fc02e384b74418679983a97385644b67e1263b"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll"]
git-tree-sha1 = "68da27247e7d8d8dafd1fcf0c3654ad6506f5f97"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "44ec54b0e2acd408b0fb361e1e9244c60c9c3dd4"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "5b0263b6d080716a02544c55fdff2c8d7f9a16a0"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.10+0"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f233c83cad1fa0e70b7771e0e21b061a116f2763"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.2+0"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "801a858fc9fb90c11ffddee1801bb06a738bda9b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.7+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "00af7ebdc563c9217ecc67776d1bbf037dbcebf4"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.44.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a63799ff68005991f9d9491b6e95bd3478d783cb"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.6.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "446b23e73536f84e8037f5dce465e92275f6a308"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+1"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c3b0e6196d50eab0c5ed34021aaa0bb463489510"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.14+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6a34e0e0960190ac2a4363a1bd003504772d631"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.61.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4bba74fa59ab0755167ad24f98800fe5d727175b"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.12.1+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "125eedcb0a4a0bba65b657251ce1d27c8714e9d6"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.17.4+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "56d643b57b188d30cccc25e331d416d3d358e557"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.13.4+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "646634dd19587a56ee2f1199563ec056c5f228df"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.4+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "91d05d7f4a9f67205bd6cf395e488009fe85b499"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.28.1+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "07b6a107d926093898e82b3b1db657ebe33134ec"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.50+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll"]
git-tree-sha1 = "11e1772e7f3cc987e9d3de991dd4f6b2602663a5"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.8+0"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b4d631fd51f2e9cdd93724ae25b2efc198b059b1"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.7+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "14cc7083fc6dff3cc44f2bc435ee96d06ed79aa7"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "10164.0.1+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e7b67590c14d487e734dcb925924c5dc43ec85f3"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "4.1.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "fbf139bce07a534df0e699dbb5f5cc9346f95cc1"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.9.2+0"
"""

# ╔═╡ Cell order:
# ╟─0f8cd1bd-6abf-4466-a30c-a359afbda4cc
# ╟─cf40074a-ccd7-4304-8ed7-1572a25acbb3
# ╟─e41f8a12-e203-4624-87c2-a7e2771c3a6c
# ╟─08a790cc-47cf-4764-9f75-8d0a72118501
# ╟─1a4596e3-e949-4c3a-9a5a-c02cd02fcfeb
# ╟─01f8f66b-8101-4296-86ec-0a0aba26c368
# ╟─4ea01a5e-cb21-4135-a8e3-92f88eb2a322
# ╟─e9a658d3-0f3a-4a0a-9da2-0d6074ca2af4
# ╟─552e5d38-2099-44fc-9b2d-5a6cb2e9e623
# ╟─5322c81f-b04f-46e8-9c07-56238a02d889
# ╟─f9f98ea7-e273-4d72-8100-20de86c75275
# ╟─b2ed1ca3-a8b3-4a3a-b703-2a2ae3e5fb97
# ╟─e6a2d00e-1ce5-4526-8cd9-5db7ec666101
# ╟─71dfd868-44ad-4141-8c12-b11133613c66
# ╟─36a4237f-773d-4972-a764-eb1ee5a129c9
# ╟─1238538d-8671-4936-8886-1e0df078b7a3
# ╟─6720a2a5-b7a5-4bb0-806f-3c171669459b
# ╟─1093527c-87fb-4870-b398-2d927a738467
# ╟─5d16d469-5c5c-44de-b226-b7f86cf8f9de
# ╟─3f05ebea-40fc-4733-9b6f-ce3b0a4bc813
# ╟─82ab157a-13ca-466a-8ad6-33993b552e8f
# ╟─1f8863ca-836f-4660-8f84-7a7a4bc6c926
# ╟─e28655a4-f7f9-44c0-9f68-b0c134bf6320
# ╟─f47ff613-f7af-452e-9df0-1297c975f1bd
# ╟─98ae640e-c8f9-4cff-8199-7377bd7c3f61
# ╟─27090b64-5638-4adf-b3f0-d93c83d15283
# ╟─0bc74e86-0e0d-4cc5-9a21-45c9a526ef67
# ╟─df1a9b5c-4e6c-4539-a866-4c106f9644d1
# ╟─70acba6e-ae13-4260-b85c-c9bf725618e5
# ╟─0bf7a852-74fc-479d-a4b8-34693cf082fe
# ╟─b59a030a-12a0-4721-9855-c1b13dea545c
# ╟─95460c65-0ad0-4345-9e89-e4a32d7e5608
# ╟─610e2c1d-717b-4daf-86a2-2baebddbe48c
# ╟─16890006-2486-4572-b685-8fe7bed7f56b
# ╟─394bd374-6ff0-411e-bf96-d844554a5e12
# ╟─c7c8459e-83c3-45a9-8b8a-ad14be941dbf
# ╟─134799ac-b3cb-40a3-ab9c-ef78d79b140f
# ╟─0b8c48ee-e28a-48e3-ad13-cabafee57802
# ╟─9e308608-d32c-4917-b869-384a2a00104f
# ╟─1524fb6b-c81b-49e1-a569-9e840ca5c5dc
# ╟─866d50e6-e827-4ddd-a28e-71aa9032b716
# ╟─1bda4fdf-8b1f-4a05-9d76-afd97a7084f0
# ╟─00898e51-080e-4e87-85c0-e9ea1c9dd4c1
# ╟─9bd7bc63-abcb-4cc3-9d1c-0db0621abbe8
# ╟─810f5c52-50b7-491d-8d43-e8c423e1f501
# ╟─35383e93-7b89-4852-84d9-ace4909368ea
# ╟─1a488c4d-b73d-4097-9c31-8eed674cb22c
# ╠═7773a1bd-be10-42d6-992d-f1ea67aead4e
# ╠═d0d09f83-a8d7-4f40-b3b6-9585c098f09a
# ╠═a97d2696-8616-441b-a536-6bf0d27befa2
# ╠═2247e1f0-105e-482b-9298-5d32a96225e9
# ╠═c00983db-f555-498d-93b7-142367b25ae6
# ╠═bb56acae-7dca-4000-90d1-2adc441676e3
# ╠═c4de022d-f5ce-4f93-803b-c40739c1acf1
# ╠═7a7f5ae9-adb5-4ae6-ae73-4e83ce709b8d
# ╟─8a0795d5-a5e3-48d3-9325-c19e3b2170d0
# ╟─94b6e3ae-30a3-4719-acac-dd15e48207ec
# ╟─db7fa0c4-f55a-4ef2-b8d7-1063af82f459
# ╟─350f0bdb-ac51-475e-a0de-c6fc64b56032
# ╠═46b6eadd-586d-4cda-8e45-f04ddc07fb30
# ╠═e0a6ef0f-a6b2-4be7-abfc-7f21503a5820
# ╠═13df20dc-8ff1-4395-aae9-a7f06f50eb49
# ╠═0eaa081f-4499-4e53-bfb8-9bd84b69a235
# ╠═ee768c39-18ff-414f-afd0-afa52317c857
# ╠═cd9febd3-904f-4bf7-bd11-5acbd5add81a
# ╠═d23f83ff-3ffb-416d-bdbe-1ebffc49204e
# ╠═e29373e5-525e-42f2-bed7-1dce3878b330
# ╠═b2b58c55-e297-4c4e-b1b3-f31056161dff
# ╠═3ac1b00e-f25b-432c-a5fd-a9ed994cd0a5
# ╠═632135c0-966b-444d-a670-c55439794e46
# ╟─eecc768d-f3a7-4415-9981-f668cb9370bf
# ╟─12b3e43f-b97c-4c5b-9f7f-c008c107d5cb
# ╠═8e141c56-cf6c-459f-97d4-7de917f64432
# ╠═172db7ff-7a72-45c4-99fb-7a122996728c
# ╠═7ffba3ce-21cb-4543-8a2d-61e6f87f6c9b
# ╠═1c28b4ee-7d20-4471-a703-0c8d267b6386
# ╠═da488f81-1516-4034-9a23-3d84f5342617
# ╠═2b262fd9-a25d-49df-99e9-3a3290a59d66
# ╠═4a404857-3667-43c0-bc77-1c0e43956520
# ╠═ba2d01cd-232f-4fea-b9e7-bcfe3206b336
# ╠═66f12e98-d090-4243-9073-93adc8176e9c
# ╠═401cd7ab-6a06-4dbb-8b36-c9ffefe14bb0
# ╠═b0200b11-609d-4cb7-b8b2-56dd284cf996
# ╟─0a23bd0a-52ac-4b9c-b33f-a7b54c60da65
# ╟─fa88c116-03eb-477c-9c2f-83a83da27b1c
# ╟─c0cb8506-a8e5-42ef-8372-dc952da9f5cf
# ╠═ee2e051c-e9f3-48ec-9821-b8ad1b2ff90f
# ╠═3efa96ab-2f37-4992-a746-93614358f65a
# ╠═e6aef6d2-0e34-4ef7-bed9-84d8d3631f16
# ╠═f5af2bb9-76b7-4eba-99bd-4d94c9eaa039
# ╠═930436b5-61b8-4a20-a314-8c14729422fd
# ╠═e37f152b-49d6-4b16-b6e6-e4205b9baeef
# ╠═4c320ce6-9088-4f2c-807f-3ea11867b7e3
# ╠═a3aa6282-c81e-4ca3-b481-250fa432224f
# ╠═3c3bcfc4-7734-4517-840d-58618f3e6401
# ╟─84ebc8fa-e8e1-4681-b1f1-4d2ad815dd19
# ╟─d986ca61-12b3-4d69-80ca-e39cf203bd47
# ╠═5bbf68bf-f875-4bc6-b0bf-14c929ba10a7
# ╠═6ee0e218-9d1f-4c42-93bb-d35b3d515284
# ╠═76248992-0240-4856-a7b1-b49cf1de3e8d
# ╠═35ab6d04-9654-4817-8b67-deade695da39
# ╠═5ba14cc9-01c2-40e6-9660-a08d84e4d9b2
# ╠═0dfe81fa-e6ba-4160-a909-47a89e0047d0
# ╠═08b9a33f-9cb4-45d4-8450-25d11c620776
# ╠═2904acca-27d9-4152-83c2-a8eb3e03c824
# ╠═f9bfc461-cbbd-479f-829d-991bfa6a086b
# ╟─40fc37d4-5650-4148-9d55-e8f47023d8cb
# ╟─115fb585-3521-45d1-bfef-c14e9023491d
# ╠═3875d7ad-e592-4d50-84ad-760a35a16801
# ╟─61071afc-5f68-4362-afe8-7558b8a7cbb3
# ╟─6ac92bd1-0b05-461e-b123-7b8d483945c1
# ╠═3f4d7f27-2d4a-46ed-8e8b-62d68afd97dd
# ╟─c92581e1-a4c4-46c9-9cb4-ee7045d9d634
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
