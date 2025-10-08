### A Pluto.jl notebook ###
# v0.20.18

#> [frontmatter]
#> image = "https://github.com/Ricardo-Luis/me-2/blob/051ec7aeb8ecca8b368e72114d3184d8df621818/images/card/Starter.png?raw=true"
#> title = "Dimensionamento de reóstato de arranque"
#> date = "2025-10-07"
#> layout = "layout.jlhtml"
#> description = "Neste documento apresenta-se o dimensionamento de um reóstato de arranque para um motor de corrente contínua. O exemplo apresentado utiliza um motor de excitação série. Apresenta-se o cálculo de dimensionamento detalhado, complementado pela representação gráfica da manobra de arranque através das características de velocidade nos pontos de operação do reóstato de arranque."
#> 
#>     [[frontmatter.author]]
#>     name = "Ricardo Luís"
#>     url = "https://ricardo-luis.github.io"

using Markdown
using InteractiveUtils

# ╔═╡ 502d8240-a046-11f0-1823-f35100609054
using PlutoUI, PlutoTeachingTools, Latexify, LaTeXStrings, Plots, Dierckx
#= 
Brief description of the used Julia packages:
  - PlutoUI.jl, to add interactivity objects
  - PlutoTeachingTools.jl, to enhance the notebook
  - Plots.jl, visualization interface and toolset to build graphics
  - Dierckx.jl, tool for data interpolation
  - Latexify.jl, LaTeX formatted strings from Julia objects
  - LaTeXStrings.jl, to type LaTeX equations in string literals in the Julia
=#

# ╔═╡ 762251b9-726a-40f5-bee7-6398b40d0274
TwoColumnWideLeft(md"`Starter.jl`", md"`Last update: 07·10·2025`")

# ╔═╡ bdcfecca-d598-4ee2-8a88-43dceb24f03d
md"""
---
$\textbf{MÁQUINAS ELÉTRICAS DE CORRENTE CONTÍNUA}$

$\colorbox{Bittersweet}{\textcolor{white}{\textbf{Dimensionamento do reóstato de arranque: exemplo de um motor série}}}$
---
"""

# ╔═╡ ee1c1d10-371c-4a18-8fcd-905d174303d6
md"""
# Introdução
"""

# ╔═╡ bbaad8c7-aed0-4c43-bc5b-38482c9f23f1
md"""
A ligação de um motor de corrente contínua (CC) a uma fonte de tensão fixa requer a existência de um reóstato de arranque para limitar o valor da corrente de arranque, $I_{arr}$. Exceptuam-se os motores de potência reduzida $(< 1\: \mathrm{CV})$.

A manobra de arranque é exectuda por um reostato ligado em série com o enrolamento induzido do motor CC, [^Fig_1]. O reostato é constituído por diversos pontos de contacto, entre os quais existem resistências dimensionadas de modo a permitir a proteção da motor CC durante a fase de arranque, limitando a corrente de arranque a um valor máximo, $I_{max}$. Simultaneamente, durante a manobra de arranque, o reostato tem de assegurar uma corrente mínima de funcionamento, $I_{min}$, de modo a permitir o desenvolvimento de binário acima do binário de carga aplicado ao veio, para que o rotor possa acelerar até à velocidade de regime permanente.
"""

# ╔═╡ f537b891-986a-4a8c-8553-c02a79bddf5b
let
# raw_url -> on github draw.io file click the "Raw" button (top right, of file view) and then copy the URL from your browser address bar:
	raw_url = "https://raw.githubusercontent.com/Ricardo-Luis/me-2/refs/heads/main/draw/starter/starter.drawio"

# viewer_url build:
	viewer_url = "https://viewer.diagrams.net/?highlight=0000ff&edit=_blank&layers=1&nav=1#U" * raw_url

# HTML:
HTML("""
<iframe frameborder="0" style="width:100%;height:400px;" 
        src="$(viewer_url)">
</iframe>
""")
end

# ╔═╡ d95abe31-908d-48a8-ab2c-fbaede55b03e
md"""
[^Fig_1]: Interior de um reóstato de arranque por pontos.
"""

# ╔═╡ 69bef6ba-8359-4fd4-ae51-a48ff2d030ab
md"""
As diversas resistências que constituem o reóstato de arranque são dimensionadas prevendo as condições de funcionamento do motor durante o procedimento de arranque, pois a velocidade, $n$, e consequentemente a força contraeletromotriz, $E'$, vão alterando durante este processo.
"""

# ╔═╡ 20dde8b7-3d53-4634-954a-a8cb6d4b7241
md"""
A corrente máxima de arranque em geral toma valores entre:

$$I_{max}=1{,}5 \ldots 2{,}00 \times I_n$$

A corrente mínima depende do conhecimento do binário de carga na aplicação em concreto do motor CC. Na pior situação deve-se possibilitar o arranque do motor a plena carga, ou seja:

$$I_{min}=I_n$$
"""

# ╔═╡ a6630208-5af4-424c-82d0-2cca2030f48b


# ╔═╡ 16f39d53-8dac-4b6d-8159-11728fed434d
md"""
# Motor Série (dados)
"""

# ╔═╡ a1fabe35-6193-4998-9f1c-d33a22a8c6a8
md"""
Considere um motor série $250$ HP, $500$ V, $1750$ rpm, e rendimento nominal, $\eta=84\: \%$.
"""

# ╔═╡ 83b90e21-8b73-4f29-88e1-b818e4ecf6f4
Pₕₚ, Uₙ, nₙ, η = 250, 500, 1750, 0.84 				# HP, V, rpm, efficiency

# ╔═╡ 4a8c8e2b-af3c-4d6b-9269-8c87c79936a4
md"""
As resistências dos enrolamentos indutor e induzido, $0.034\:\Omega$ e $0.110\:\Omega$, respetivamente.
"""

# ╔═╡ 38b2ad1e-48ce-4cd0-b51d-832d8706a9db
Rs, Ri = 0.034, 0.110; 								# Ω, Ω

# ╔═╡ 9dd412f6-6f12-4227-9016-865f80071425
md"""
A característica magnética desta máquina CC às $1000$ rpm, vem dada na [^Fig_2]:
"""

# ╔═╡ 5060c750-3af4-4c32-9894-d6813e3a6d17
i=[0, 111, 222, 333, 444, 555, 666, 777]; 						# A

# ╔═╡ d51c3876-25d5-4838-ad04-c00c8d684af4
E₀=[16.0, 120.0, 197.0, 232.6, 249.2, 252.0, 253.0, 253.4];     # V, @1000rpm

# ╔═╡ 13755061-0542-4409-bad0-e43c425516c8
plot(i, E₀, size=[400,400], xaxis=[0,800], yaxis=[0, 275], legend=:none,
	 xlabel=L"I_{exc} \quad (\mathrm{A})", xminorticks=4,
	 ylabel=L"E_0 \quad (\mathrm{V})", yminorticks=5)

# ╔═╡ 5e3156fd-fb2c-45f5-ad85-24861013fe41
md"""
[^Fig_2]: Característica magnética do motor série às $1000$ rpm.
"""

# ╔═╡ 140f3d6c-776b-425f-9592-91d5c63602db


# ╔═╡ e33f5a13-12c5-4765-b1c3-598deff563ff
md"""

$\colorbox{Bittersweet}{\textcolor{white}{\textbf{Objetivo}}}$

**Dimensionar o reóstato de arranque por pontos, de modo a limitar a corrente durante a manobra de arranque do motor série:**

$I_n \leqslant I_{arr} \leqslant 1{,}5 \times I_n$
"""

# ╔═╡ 74498342-cad5-4843-a8a9-1f01805d9bf1


# ╔═╡ ddf37cb5-7012-4d5e-b3dd-1c83988c777b
md"""
# Dimensionamento do reóstato de arranque
## Cáculo  da $I_n$, $I_{min}$, $I_{max}$
"""

# ╔═╡ 5c657d75-e345-4b0d-9cde-ed90194361f0
md"""
$I_n=\frac{P_u}{\eta \: U_n}$
"""

# ╔═╡ ebe5fd6d-3b42-46d5-9dab-5b13a8420113
Pᵤ = Pₕₚ * 746 	  			# 1 HP <> 746 W

# ╔═╡ ad410e59-d80f-486d-bfc2-5eed75f9b128
begin
	Iₙ = Pᵤ / (η*Uₙ)
	Iₙ = round(Iₙ, digits=0)
end

# ╔═╡ f251db3f-b5a9-4f66-86bd-fb96daf59025
Imin, Imax = Iₙ, 1.5*Iₙ 

# ╔═╡ 63c80b5e-0715-483f-80fa-b8b8c164657f
md"""
Assim, tém-se a corrente mínima, $$I_{min}=$$ $(Iₙ) A, para o funcionamento da máquina na manobra de arranque.

Calculando a corrente máxima, $$I_{max}=1{,}5 \times I_n$$, ou seja, o reóstato de arranque deve manter a corrente no intervalo:$\quad$ $(Iₙ) A $$\leqslant I_{arr} \leqslant$$ $(Imax) A 



"""

# ╔═╡ 298260a0-110a-467a-be65-af45b90c1825
let
# raw_url -> on github draw.io file click the "Raw" button (top right, of file view) and then copy the URL from your browser address bar:
	raw_url = "https://raw.githubusercontent.com/Ricardo-Luis/me-2/refs/heads/main/draw/starter/starter_scheme.drawio"

# viewer_url build:
	viewer_url = "https://viewer.diagrams.net/?highlight=0000ff&edit=_blank&layers=1&nav=1#U" * raw_url

# HTML:
HTML("""
<iframe frameborder="0" style="width:100%;height:500px;" 
        src="$(viewer_url)">
</iframe>
""")
end

# ╔═╡ e0808889-1a2f-4ac6-bce3-98fb78a89957
md"""
Percorrendo o circuito de corrente estabelece-se a seguinte equação de funcionamento do motor série, em regime permanente, em qualquer posição do reóstato de arranque, $R_{arr}$:

$-U + (R_{arr} +R_i + R_s) \: I_{arr} + E' = 0 \quad\Leftrightarrow$

$\Leftrightarrow\quad I_{arr}=\frac{U-E'}{(R_{arr} +R_i + R_s)}$


As escolha adequada, do número de contactos e das resistências entre contactos que constituem o reóstato de arranque, deve permitir que a corrente de arranque esteja contida nos limites estabelecidos para a manobra de arranque. 
"""

# ╔═╡ 15c4b93a-a464-496e-b95f-7f43cd756bc5
md"""
O processo de dimensionamento do reóstato de arranque consiste em calcular as diversas resistências totais do circuito, até que:

$R_n \leqslant (R_i+R_s)$

em que o índice "$n$", corresponde ao número de contactos necessários para o reóstato de arranque.
"""

# ╔═╡ 5ab5e064-1f7c-4742-9829-333c737a443e
Ri + Rs 				# Ω

# ╔═╡ 111e74fb-4869-4cc6-bc2a-5312af0f9daa


# ╔═╡ 4332b02c-12db-42ca-a70c-27b2edeffa84
md"""
---
"""

# ╔═╡ 74460aa0-9add-4883-894f-e75dd9407552
md"""
## 1º contacto $(R_1)$
"""

# ╔═╡ c7828b9d-f719-4a0e-ae27-3a89722c59ff
begin
	R₁ = Uₙ/Imax
	R₁ = round(R₁, digits=3)
end

# ╔═╡ c6c6366a-d660-4366-9862-9436d6eb759c


# ╔═╡ 3ce70160-4cdf-4acc-83e1-ee6dce02c762
md"""
### Cálculo da velocidade, $n_1$
"""

# ╔═╡ 34393ee3-8afa-4b3f-be79-c2b4385df490
md"""
Após ligar o motor série com o reóstato de arranque totalmente inserido, verifica-se que a velocidade cresce até um valor bastante limitado face à velocidade nominal, proporcionando assim um arranque suave.
"""

# ╔═╡ 3385447f-98b4-4545-8b49-de47cdf38920
md"""
À medida que a velocidade aumenta, durante a fase de arranque, aumenta a força contraeletromotriz, $E'=k\: \phi \: n$, por conseguinte a corrente de arranque decresce até ao valor de $I_{min}$:
"""

# ╔═╡ 3c109614-201f-4b63-972e-43905d4a3b06
E₁ʼ = Uₙ - R₁*Imin 				# V

# ╔═╡ cf031544-6e74-4446-8e56-acd169abf4b9
md"""
Para o cálculo da velocidade de regime permanente, com o reóstato de arranque posicionado no 1º contacto, tem de se averiguar o valor do fluxo magnético do motor série para o valor mínimo da corrente de arranque, $k\phi(I_{min})$, consultando a característica magnética:
"""

# ╔═╡ 138efe1e-08b1-4803-9317-390a56f358b9
Kϕᴵᵐⁱⁿ = 249.2/1000 			# V/rpm

# ╔═╡ 7f368886-4932-46d5-a5e7-f7ddb5f77948
md"""
Assim, a velocidade estabilizada, $n_1$, com o reóstao na posição de arranque, $R_{arr_1}=R_1-(R_i+R_s)$, vem dada por:
"""

# ╔═╡ e2be86d0-6c61-43fe-8a88-8fddf52e7aaf
n₁ = E₁ʼ/Kϕᴵᵐⁱⁿ 				# rpm

# ╔═╡ cce47cfd-e01d-4f14-8a71-e1c2db9aae96


# ╔═╡ 2bbad277-794a-4af3-9742-7e7b8101b8b8
md"""
> **Nota:** No presente exemplo de cálculo despreza-se a queda de tensão devido à reação magnética do induzido, $\Delta E$, para simplicidade na análise, o que resulta $E_0'=E'$.\
> Na situação de $\Delta E \neq 0$, é necessário adicionar esses valores de $\Delta E(I_{min})$ e $\Delta E(I_{max})$ fazendo, genericamente, $E_0'=E'+\Delta E$ e só depois determinar a velocidade, $n=\dfrac{E_0'}{k \: \phi(I_{arr})}\:$.

"""

# ╔═╡ 8007e632-958d-4e64-96f8-4f5f0e3d7f25


# ╔═╡ 3c91700d-d018-4fe9-9e34-a0986a5d164d
md"""
---
"""

# ╔═╡ c2f1ade6-b360-4429-b56b-22aaa8408081
md"""
## 2º contacto $(R_2)$
"""

# ╔═╡ 5eb4d8e5-9b2f-4d76-9f70-4a1540e5419a
md"""
Quando o reóstato de arranque é posicionado no **2º contacto**, $R_{arr_2}=R_2-(R_i+R_s)$, tem de limitar a corrente em $I_{max}$. No entanto, a máquina vem da situação anterior (já em movimento), e por conseguinte, a velocidade, $n$, e a força contraeletromotriz, $E'$, não são nulas.

Por outro lado, na transição do 1º para o 2º contacto, a corrente passa do valor $I_{min} \to I_{max}$, pois $R_{arr_2}$, está dimensionada para tal, no entanto, essa transição afeta o fluxo magnético da máquina, dada a sua dependência do valor da corrente que a percorre, ou seja  $K\phi=\mathrm{f}(I_{arr})$.


"""

# ╔═╡ e0e28319-3984-4545-b07b-7e39ec39757b
md"""
Consultando novamente a característica magnética, tem-se
 o valor correspondente ao fluxo magnético, traduzido por $k\phi(I_{max})$, no instante, em que o reóstato inicia o 2º contacto:"""

# ╔═╡ 7a6a5c34-7fa6-4f41-8ac1-4ed425afa715
Kϕᴵᵐᵃˣ = 253/1000 				# V/rpm

# ╔═╡ 9456d914-d674-4f2a-a08e-0b7b4974bb33
md"""
Assim, $R_2$ vem dado por:
"""

# ╔═╡ 7b884642-11c2-41b4-85d9-4a4ed9785d55
E₂ʼʼ= Kϕᴵᵐᵃˣ * n₁ 				# V

# ╔═╡ 86dc8f95-2ed1-4beb-996c-0b90b3ec0bf5
begin
	R₂ = (Uₙ - E₂ʼʼ)/Imax
	R₂ = round(R₂, digits=3) 	# Ω
end

# ╔═╡ 864b35e7-ae90-4681-81a5-fda7d8545902


# ╔═╡ be541c02-e315-4961-9fe2-0d3d6d4a3bd9
md"""
### Cálculo da velocidade, $n_2$
"""

# ╔═╡ dfb250ee-a1c2-4e7a-9ef5-9c98b928cd79
E₂ʼ = Uₙ - R₂*Imin 				# V

# ╔═╡ b4f257e6-c3ea-4eee-8d04-c12a42b142ef
n₂ = E₂ʼ/Kϕᴵᵐⁱⁿ 				# rpm

# ╔═╡ 4467639d-bbc1-46a5-84b5-59c5ff0e3610


# ╔═╡ e68ccb80-378a-47a0-951b-2f681552e0b3
md"""
---
"""

# ╔═╡ 0004eb67-bc94-4205-bec1-24f8026c45df
md"""
## 3º contacto $(R_3)$
"""

# ╔═╡ aad6f5ae-d766-4069-b043-c04f53a11fac
E₃ʼʼ=Kϕᴵᵐᵃˣ * n₂ 				# V

# ╔═╡ a40bf10f-b66a-41bb-a735-ad259ea156ea
begin
	R₃ = (Uₙ - E₃ʼʼ)/Imax
	R₃ = round(R₃, digits=3) 	# Ω
end

# ╔═╡ 065de539-c74b-4128-bed4-d2e1d074849d


# ╔═╡ 455ff795-796b-4d19-bba5-d571867b7c17
md"""
### Cálculo da velocidade, $n_3$
"""

# ╔═╡ f89093aa-becd-49cf-9c6b-e05ac179590b
E₃ʼ = Uₙ - R₃*Imin 				# V

# ╔═╡ 0d947a2c-b6a2-4a72-8e4b-7f4a30ca7ae0
n₃ = E₃ʼ/Kϕᴵᵐⁱⁿ 				# rpm

# ╔═╡ cfa9383c-c63b-488e-96a2-7ef0fe15b295


# ╔═╡ 87523c64-37e6-4695-aed7-25f8ae45c26b
md"""
---
"""

# ╔═╡ 2e3b8442-1d46-4716-ac9e-a9df979ed8b8
md"""
## 4º contacto $(R_4)$
"""

# ╔═╡ 129bd403-a3de-4f36-ab3a-fd9e3fb808cf
E₄ʼʼ=Kϕᴵᵐᵃˣ * n₃ 				# V

# ╔═╡ 6e14d70a-3dcb-4db6-b680-ca0c77d9fd2e
begin
	R₄ = (Uₙ - E₄ʼʼ)/Imax
	R₄ = round(R₄, digits=3) 	# Ω
end

# ╔═╡ 6d4321d9-a76d-4363-98f4-d79fc5b79ac7


# ╔═╡ 2f627762-c215-47a8-b3f5-59939edda26a
md"""
### Cálculo da velocidade, $n_₄$
"""

# ╔═╡ 011f68dd-3b07-4f25-bb09-d79233818ab5
E₄ʼ = Uₙ - R₄*Imin 				# V

# ╔═╡ 49d09fef-edaa-4b35-969f-b8b6b30905c0
n₄ = E₄ʼ/Kϕᴵᵐⁱⁿ 				# rpm

# ╔═╡ 1cda3c7a-7e1a-4861-8d90-e44af59f1fb5


# ╔═╡ 5d695821-0fa4-4344-8090-ba4950861ec0
md"""
## 5º contacto $(R_5)$
"""

# ╔═╡ 400adc40-8a50-4f55-96c1-65c69212be87
E₅ʼʼ=Kϕᴵᵐᵃˣ * n₄ 				# V

# ╔═╡ 021ed44b-d55a-4fce-8871-7ff313d95e3f
begin
	R₅ = (Uₙ - E₅ʼʼ)/Imax
	R₅ = round(R₅, digits=3) 	# Ω
end

# ╔═╡ 0337dbfd-32ec-401c-a483-0dfb8ce65527
md"""
No 5º contacto verifica-se: $R_5 \leqslant (R_i+R_s)$, tal significa que o reóstato chegou ao fim da manobra de arranque, pois a resistência mínima do circuito é dada pela soma das resistências do induzido e indutor série.

Assim, são necessários 5 contactos, entre os quais são colocadas 4 resistências:
"""

# ╔═╡ 776c4aaa-04e9-4548-b453-fce5ae58a607
begin
	r₁ = R₁ - R₂
	r₂ = R₂ - R₃
	r₃ = R₃ - R₄
	r₄ = R₄ - (Ri+Rs)
	r₁, r₂, r₃, r₄ = round.([r₁, r₂, r₃, r₄], digits=3)					# Ω
end

# ╔═╡ 4b6fac5a-7fec-44bb-b04e-6618a0fecd11
md"""
A resistência total do reóstato de arranque, $R_{arr_t}$, é dada por:

$R_{arr_t}=\sum_{n=1}^{n-1}r_n$

ou,

$R_{arr_t}=R_1-(R_i+R_s)$

"""

# ╔═╡ a98f20e3-1ead-48f8-a19b-e9af69245a82
Rₐᵣᵣᵗ¹ = sum([r₁, r₂, r₃, r₄])			# Ω

# ╔═╡ c926f406-b991-49db-971c-63855073479b
Rₐᵣᵣᵗ² = R₁ - (Ri + Rs) 				# Ω

# ╔═╡ 6f93bd77-d0c7-4c56-9738-15743f616b42


# ╔═╡ 33071325-e814-4c88-81fc-3e91cd42f443
md"""
### Cálculo da velocidade, $n_f$
"""

# ╔═╡ c3d44faa-c63f-4fe3-97f4-b253211431c6
md"""
Supondo carga mecânica nominal aplicada ao veio do motor, tem-se:
"""

# ╔═╡ ccf74750-9559-4f3b-9d69-6479f5543a40
Eᶠʼ = Uₙ - (Ri+Rs)*Imin 				# V

# ╔═╡ 028c6e91-a4df-4aac-862b-d9d68f5b716a
begin
	nᶠ = Eᶠʼ/Kϕᴵᵐⁱⁿ 					# rpm
	nᶠ = round(Int, nᶠ)
end

# ╔═╡ 96e61368-9bde-4c06-a242-3789533c439e


# ╔═╡ 5ad59e66-0264-45ea-9700-9831e29749e0
md"""
# Quadro resumo
"""

# ╔═╡ a20470d5-dab8-4461-994a-851da1e095ce
md"""
Na tabela seguinte apresentam-se os resultados obtidos no dimensionamento do reóstatode arranque. Observe-se como progressivamente as velocidades em cada contacto do reóstato vão subindo:
"""

# ╔═╡ e5ed3891-fdd2-4904-b1a0-2cdde2ae665c
md"""

| Dimensionamento $R_n$ | $\qquad$Velocidade$\qquad$ | resist. entre contactos |
|:---------------------:|:--------------------:|:-----------------------------:|
| $$R_1=$$ $(R₁) Ω      | $$n_1=$$ $(round(Int, n₁)) rpm | --                  |
| $$R_2=$$ $(R₂) Ω      | $$n_2=$$ $(round(Int, n₂)) rpm | $$r_1=$$ $(r₂) Ω    |
| $$R_3=$$ $(R₃) Ω      | $$n_3=$$ $(round(Int, n₃)) rpm | $$r_2=$$ $(r₂) Ω    |
| $$R_4=$$ $(R₄) Ω      | $$n_4=$$ $(round(Int, n₄)) rpm | $$r_3=$$ $(r₃) Ω    |
| $$R_5=$$ $(R₅) Ω $$\leqslant (R_i+R_s) \implies 5\: \mathrm{contactos}$$ | $$n_f=$$ $(nᶠ) rpm | $$r_4=$$ $(r₄) Ω  |

"""

# ╔═╡ 225a65c4-6cdf-4f55-8371-8695da827d3f


# ╔═╡ 95f244bc-f4c1-4e66-9880-51cf83a525f5
md"""
# Observação da manobra de arranque
"""

# ╔═╡ 0dcb2287-d36a-4b3d-8631-97b5c95a8e03
I=0:1:777 								# A

# ╔═╡ 3833d549-ba52-48a1-8392-058f5cac59e6
# computational method of querying the E₀(I) curve, by interpolating the data using Pkg Dierckx.jl
begin
	E_int = Spline1D(i, E₀)  
	E = E_int.(I)
	E = round.(E, digits=1)
	kϕ = E/1000 						# V/rpm
end

# ╔═╡ 602fa17e-84ba-4a33-9529-3c632f8a758a
n1 = (Uₙ .- R₁*I) ./ kϕ; 				# rpm

# ╔═╡ a7d248ac-a2d9-41a6-866d-cc62520a128a
n2 = (Uₙ .- R₂*I) ./ kϕ; 				# rpm

# ╔═╡ c0dd48c0-6b25-4e12-a8be-d5de7befc5c5
n3 = (Uₙ .- R₃*I) ./ kϕ; 				# rpm

# ╔═╡ aae503fc-9717-4af3-b9e2-b911c20518ed
n4 = (Uₙ .- R₄*I) ./ kϕ; 				# rpm

# ╔═╡ 090d8c19-10a8-49f3-84d9-0756122d5cf1
n = (Uₙ .- (Ri+Rs)*I) ./ kϕ; 			# rpm

# ╔═╡ a2691fec-83cb-4b71-b8ed-1515c3eefe64
begin
	part = Imin .<= I .<= Imax
	
	plot(I,n1, lw=2, lc=:blue, label=L"n=\mathrm{f}\:(I), R_1")
	plot!(I[part], n1[part], lw=6, lc=:grey, alpha=0.6, label=:none)
	plot!([Imin, Imax], [n₁, n₁], lw=6, lc=:grey, alpha=0.6, label=:none)
	
	plot!(I,n2, lw=2, lc=:red, label=L"n=\mathrm{f}\:(I), R_2")
	plot!(I[part], n2[part], lw=6, lc=:grey, alpha=0.6, label=:none)
	plot!([Imin, Imax], [n₂, n₂], lw=6, lc=:grey, alpha=0.6, label=:none)
	
	plot!(I,n3, lw=2, lc=:purple, label=L"n=\mathrm{f}\:(I), R_3")
	plot!(I[part], n3[part], lw=6, lc=:grey, alpha=0.6, label=:none)
	plot!([Imin, Imax], [n₃, n₃], lw=6, lc=:grey, alpha=0.6, label=:none)
	
	plot!(I,n4, lw=2, lc=:green, yaxis=[0,3500], yminorticks=5, label=L"n=\mathrm{f}\:(I), R_4")
	plot!(I[part], n4[part], lw=6, lc=:grey, alpha=0.6, label=:none)
	plot!([Imin, Imax], [n₄, n₄], lw=6, lc=:grey, alpha=0.6, label=:none)

	plot!(I,n, lw=2, lc=:black, xaxis=[0,800], xminorticks=10, label=L"n=\mathrm{f}\:(I), R_{arr}=0\:\Omega")
	plot!(I[part], n[part], lw=6, lc=:grey, alpha=0.6, label=L"\mathbf{Manobra \:de\:arranque}")
	
	vline!([Imin, Imax], ls=:dash, lc=:black, label=L"\mathrm{Limites: }I_{min}, I_{max}", legend=:topright, xlabel=L"I \quad \mathrm{(A)}", ylabel=L"n \quad \mathrm{(rpm)}", guidefontsize=12, tickfontsize=10,  legendfontsize=11, size=[650,500])
	annotate!(Imin, 250, text(" \$I_{min}=\$ $(Imin)A",:black, :center, 10))
	annotate!(Imax, 2000, text(" \$I_{max}=\$ $(Imax)A",:black, :center, 10))
end

# ╔═╡ 51351f6a-00c7-4261-b0b3-8d6b843323ec


# ╔═╡ 8a8bea37-86be-48d4-a178-d7807e6fc47e
md"""
# Considerações finais
"""

# ╔═╡ 2b10f7f5-9dea-4703-9c39-82ffc8fe5d71
md"""
A sequência de cálculo para o dimensionamento do reóstato de arranque, inicia-se com o cálculo da resistência total do circuito de potência do motor, no momento que ainda se encontra em repouso, $R_1$: 

$R_1=\dfrac{U}{I_{max}}$

A partir de $R_1$ tem-se um cálculo sucessivo de $R_n$:

$R_n=R_{n-1}\:\frac{I_{min}}{I_{max}} \: \frac{U-E_n''}{U-E_{n-1}'}$

onde:
 -  $$E_n''= k\:\phi (I_{max}) \: n_{n-1}\qquad$$, em que: $$\qquad k\:\phi (I_{max}) = \dfrac{E_0(I_{max})}{n_{mag}}$$


 -  $$E_{n-1}'= k\:\phi (I_{min}) \: n_{n-1}\qquad$$, em que: $$\qquad k\:\phi (I_{min}) = \dfrac{E_0(I_{min})}{n_{mag}}$$

O cálulo sucessivo termina na condição $R_n \leqslant (R_i+R_s)$, extraindo-se o valor do índice "$n$" que estabelece o número de contactos necessários no reóstato de arranque.
"""

# ╔═╡ e16b1f58-7672-4f2f-95a8-c9fb52bd1793
md"""
Este cálculo é válido para qualquer motor CC que contenha o enrolamento de excitação série (**motor série e motor _compound_**). 

Nos motores CC de excitaçao constante (**motor _shunt_ e motor de excitação separada**), como o fluxo magnético é independente da corrente que circula no induzido, resulta que: $$E_n''= E_{n-1}'$$, o que simplifica a expressão de cálculo sucessivo:

$R_n=R_{n-1}\:\frac{I_{min}}{I_{max}}$

"""

# ╔═╡ bdebd308-8788-4fee-9e8d-c63cc9f4ef54
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

# ╔═╡ 006314fa-dba5-4621-9399-8a225b28bc77
md"""
# *Notebook*
"""

# ╔═╡ b4774051-77da-40fc-b27d-56a868fd4f46
md"""
Documentação das bibliotecas Julia utilizadas:  [Dierckx](https://github.com/kbarbary/Dierckx.jl), [Plots](http://docs.juliaplots.org/latest/), [PlutoUI](https://featured.plutojl.org/basic/plutoui.jl), [PlutoTeachingTools](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html), [Latexify](https://korsbo.github.io/Latexify.jl/stable/), [LaTeXStrings](https://github.com/JuliaStrings/LaTeXStrings.jl).
"""

# ╔═╡ e0511ea5-75bf-4336-9495-238b4c2275d8
begin
	version=VERSION
	md"""
*Notebook* desenvolvido em `Julia` versão $(version).
"""
end

# ╔═╡ eacbfd76-0213-4f91-a404-56ac975f913f
TableOfContents(title="Índice")

# ╔═╡ 862d0c46-7bc2-47aa-92df-a7d7120cc0b0
md"""
|  |  |
|:--:|:--|
|  | This notebook, [Starter.jl](https://ricardo-luis.github.io/me-2/Starter.html), is part of the collection "[_Notebooks_ Computacionais Aplicados a Máquinas Elétricas II](https://ricardo-luis.github.io/me-2/)" by Ricardo Luís. |
| **Terms of Use** | All narrative and visual content is shared under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)), while the Julia code snippets are released under the [MIT License](https://www.tldrlegal.com/license/mit-license).|
|  | $©$ 2022-2025 [Ricardo Luís](https://ricardo-luis.github.io/) |
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Dierckx = "39dd38d3-220a-591b-8e3c-4c3a8c710a94"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Latexify = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Dierckx = "~0.5.4"
LaTeXStrings = "~1.4.0"
Latexify = "~0.16.8"
Plots = "~1.40.17"
PlutoTeachingTools = "~0.4.4"
PlutoUI = "~0.7.69"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.7"
manifest_format = "2.0"
project_hash = "cd4889ad0d27666a457a4931bc439e877778c5ed"

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

[[deps.Dierckx]]
deps = ["Dierckx_jll"]
git-tree-sha1 = "7da4b14cc4c3443a1afc64abee17f4fcb45ad837"
uuid = "39dd38d3-220a-591b-8e3c-4c3a8c710a94"
version = "0.5.4"

[[deps.Dierckx_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3251f44b3cac6fec4cec8db45d3ab0bfed51c4d8"
uuid = "cd4c43a9-7502-52ba-aa6d-59fb2a88580b"
version = "0.2.0+0"

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
git-tree-sha1 = "2ae7d4ddec2e13ad3bddf5c0796f7547cf682391"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.2+0"

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

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "Latexify", "Markdown", "PlutoUI"]
git-tree-sha1 = "d0f6e09433d14161a24607268d89be104e743523"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.4.4"

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
git-tree-sha1 = "0f27480397253da18fe2c12a4ba4eb9eb208bf3d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.0"

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
git-tree-sha1 = "372b90fe551c019541fafc6ff034199dc19c8436"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.12"

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
# ╟─762251b9-726a-40f5-bee7-6398b40d0274
# ╟─bdcfecca-d598-4ee2-8a88-43dceb24f03d
# ╟─ee1c1d10-371c-4a18-8fcd-905d174303d6
# ╟─bbaad8c7-aed0-4c43-bc5b-38482c9f23f1
# ╟─f537b891-986a-4a8c-8553-c02a79bddf5b
# ╟─d95abe31-908d-48a8-ab2c-fbaede55b03e
# ╟─69bef6ba-8359-4fd4-ae51-a48ff2d030ab
# ╟─20dde8b7-3d53-4634-954a-a8cb6d4b7241
# ╟─a6630208-5af4-424c-82d0-2cca2030f48b
# ╟─16f39d53-8dac-4b6d-8159-11728fed434d
# ╟─a1fabe35-6193-4998-9f1c-d33a22a8c6a8
# ╠═83b90e21-8b73-4f29-88e1-b818e4ecf6f4
# ╟─4a8c8e2b-af3c-4d6b-9269-8c87c79936a4
# ╠═38b2ad1e-48ce-4cd0-b51d-832d8706a9db
# ╟─9dd412f6-6f12-4227-9016-865f80071425
# ╠═5060c750-3af4-4c32-9894-d6813e3a6d17
# ╠═d51c3876-25d5-4838-ad04-c00c8d684af4
# ╟─13755061-0542-4409-bad0-e43c425516c8
# ╟─5e3156fd-fb2c-45f5-ad85-24861013fe41
# ╟─140f3d6c-776b-425f-9592-91d5c63602db
# ╟─e33f5a13-12c5-4765-b1c3-598deff563ff
# ╟─74498342-cad5-4843-a8a9-1f01805d9bf1
# ╟─ddf37cb5-7012-4d5e-b3dd-1c83988c777b
# ╟─5c657d75-e345-4b0d-9cde-ed90194361f0
# ╠═ebe5fd6d-3b42-46d5-9dab-5b13a8420113
# ╠═ad410e59-d80f-486d-bfc2-5eed75f9b128
# ╠═f251db3f-b5a9-4f66-86bd-fb96daf59025
# ╟─63c80b5e-0715-483f-80fa-b8b8c164657f
# ╟─298260a0-110a-467a-be65-af45b90c1825
# ╟─e0808889-1a2f-4ac6-bce3-98fb78a89957
# ╟─15c4b93a-a464-496e-b95f-7f43cd756bc5
# ╠═5ab5e064-1f7c-4742-9829-333c737a443e
# ╟─111e74fb-4869-4cc6-bc2a-5312af0f9daa
# ╟─4332b02c-12db-42ca-a70c-27b2edeffa84
# ╟─74460aa0-9add-4883-894f-e75dd9407552
# ╠═c7828b9d-f719-4a0e-ae27-3a89722c59ff
# ╟─c6c6366a-d660-4366-9862-9436d6eb759c
# ╟─3ce70160-4cdf-4acc-83e1-ee6dce02c762
# ╟─34393ee3-8afa-4b3f-be79-c2b4385df490
# ╟─3385447f-98b4-4545-8b49-de47cdf38920
# ╠═3c109614-201f-4b63-972e-43905d4a3b06
# ╟─cf031544-6e74-4446-8e56-acd169abf4b9
# ╠═138efe1e-08b1-4803-9317-390a56f358b9
# ╟─7f368886-4932-46d5-a5e7-f7ddb5f77948
# ╠═e2be86d0-6c61-43fe-8a88-8fddf52e7aaf
# ╟─cce47cfd-e01d-4f14-8a71-e1c2db9aae96
# ╟─2bbad277-794a-4af3-9742-7e7b8101b8b8
# ╟─8007e632-958d-4e64-96f8-4f5f0e3d7f25
# ╟─3c91700d-d018-4fe9-9e34-a0986a5d164d
# ╟─c2f1ade6-b360-4429-b56b-22aaa8408081
# ╟─5eb4d8e5-9b2f-4d76-9f70-4a1540e5419a
# ╟─e0e28319-3984-4545-b07b-7e39ec39757b
# ╠═7a6a5c34-7fa6-4f41-8ac1-4ed425afa715
# ╟─9456d914-d674-4f2a-a08e-0b7b4974bb33
# ╠═7b884642-11c2-41b4-85d9-4a4ed9785d55
# ╠═86dc8f95-2ed1-4beb-996c-0b90b3ec0bf5
# ╟─864b35e7-ae90-4681-81a5-fda7d8545902
# ╟─be541c02-e315-4961-9fe2-0d3d6d4a3bd9
# ╠═dfb250ee-a1c2-4e7a-9ef5-9c98b928cd79
# ╠═b4f257e6-c3ea-4eee-8d04-c12a42b142ef
# ╟─4467639d-bbc1-46a5-84b5-59c5ff0e3610
# ╟─e68ccb80-378a-47a0-951b-2f681552e0b3
# ╟─0004eb67-bc94-4205-bec1-24f8026c45df
# ╠═aad6f5ae-d766-4069-b043-c04f53a11fac
# ╠═a40bf10f-b66a-41bb-a735-ad259ea156ea
# ╟─065de539-c74b-4128-bed4-d2e1d074849d
# ╟─455ff795-796b-4d19-bba5-d571867b7c17
# ╠═f89093aa-becd-49cf-9c6b-e05ac179590b
# ╠═0d947a2c-b6a2-4a72-8e4b-7f4a30ca7ae0
# ╟─cfa9383c-c63b-488e-96a2-7ef0fe15b295
# ╟─87523c64-37e6-4695-aed7-25f8ae45c26b
# ╟─2e3b8442-1d46-4716-ac9e-a9df979ed8b8
# ╠═129bd403-a3de-4f36-ab3a-fd9e3fb808cf
# ╠═6e14d70a-3dcb-4db6-b680-ca0c77d9fd2e
# ╟─6d4321d9-a76d-4363-98f4-d79fc5b79ac7
# ╟─2f627762-c215-47a8-b3f5-59939edda26a
# ╠═011f68dd-3b07-4f25-bb09-d79233818ab5
# ╠═49d09fef-edaa-4b35-969f-b8b6b30905c0
# ╟─1cda3c7a-7e1a-4861-8d90-e44af59f1fb5
# ╟─5d695821-0fa4-4344-8090-ba4950861ec0
# ╠═400adc40-8a50-4f55-96c1-65c69212be87
# ╠═021ed44b-d55a-4fce-8871-7ff313d95e3f
# ╟─0337dbfd-32ec-401c-a483-0dfb8ce65527
# ╠═776c4aaa-04e9-4548-b453-fce5ae58a607
# ╟─4b6fac5a-7fec-44bb-b04e-6618a0fecd11
# ╠═a98f20e3-1ead-48f8-a19b-e9af69245a82
# ╠═c926f406-b991-49db-971c-63855073479b
# ╟─6f93bd77-d0c7-4c56-9738-15743f616b42
# ╟─33071325-e814-4c88-81fc-3e91cd42f443
# ╟─c3d44faa-c63f-4fe3-97f4-b253211431c6
# ╠═ccf74750-9559-4f3b-9d69-6479f5543a40
# ╠═028c6e91-a4df-4aac-862b-d9d68f5b716a
# ╟─96e61368-9bde-4c06-a242-3789533c439e
# ╟─5ad59e66-0264-45ea-9700-9831e29749e0
# ╟─a20470d5-dab8-4461-994a-851da1e095ce
# ╟─e5ed3891-fdd2-4904-b1a0-2cdde2ae665c
# ╟─225a65c4-6cdf-4f55-8371-8695da827d3f
# ╟─95f244bc-f4c1-4e66-9880-51cf83a525f5
# ╠═0dcb2287-d36a-4b3d-8631-97b5c95a8e03
# ╠═3833d549-ba52-48a1-8392-058f5cac59e6
# ╠═602fa17e-84ba-4a33-9529-3c632f8a758a
# ╠═a7d248ac-a2d9-41a6-866d-cc62520a128a
# ╠═c0dd48c0-6b25-4e12-a8be-d5de7befc5c5
# ╠═aae503fc-9717-4af3-b9e2-b911c20518ed
# ╠═090d8c19-10a8-49f3-84d9-0756122d5cf1
# ╟─a2691fec-83cb-4b71-b8ed-1515c3eefe64
# ╟─51351f6a-00c7-4261-b0b3-8d6b843323ec
# ╟─8a8bea37-86be-48d4-a178-d7807e6fc47e
# ╟─2b10f7f5-9dea-4703-9c39-82ffc8fe5d71
# ╟─e16b1f58-7672-4f2f-95a8-c9fb52bd1793
# ╟─bdebd308-8788-4fee-9e8d-c63cc9f4ef54
# ╟─006314fa-dba5-4621-9399-8a225b28bc77
# ╟─b4774051-77da-40fc-b27d-56a868fd4f46
# ╠═502d8240-a046-11f0-1823-f35100609054
# ╟─e0511ea5-75bf-4336-9495-238b4c2275d8
# ╠═eacbfd76-0213-4f91-a404-56ac975f913f
# ╟─862d0c46-7bc2-47aa-92df-a7d7120cc0b0
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
