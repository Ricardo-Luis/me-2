### A Pluto.jl notebook ###
# v1.0.3

#> [frontmatter]
#> tags = ["lecture", "module2"]
#> title = "Curvas características motores"
#> description = "Este exercício incide sobre as curvas de funcionamento dos motores de corrente contínua (CC), designadamente as características de velocidade, binário e mecânica. Realiza-se uma comparação entre motores de excitação constante (separada e em derivação), excitação composta (aditiva e subtrativa) e excitação série. São ainda abordadas as condições de embalamento dos motores CC."
#> chapter = 1
#> section = 5
#> image = "https://github.com/Ricardo-Luis/me-2/blob/087e6ae9406f359c461b1825e9ce233dabb54fac/images/card/DCmotors.png?raw=true"
#> layout = "layout.jlhtml"
#> date = "2026-09-11"
#> order = 5
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

# ╔═╡ 6b359fc5-ec8d-47ec-89ec-b1b214a37a82
using PlutoUI, PlutoTeachingTools, Plots, Dierckx  
#= 
Brief description of the used Julia packages:
  - PlutoUI.jl, to add interactivity objects
  - PlutoTeachingTools.jl, to enhance the notebook
  - Plots.jl, visualization interface and toolset to build graphics
  - Dierckx.jl, tool for data interpolation
=#

# ╔═╡ e227c53c-28a1-4d09-bf05-ba24236f613a
TwoColumnWideLeft(md"`DCmotors.jl`", md"`Last update: 11·09·2026`")

# ╔═╡ d45dcd85-db5f-4f9e-8f67-a82df904e0dc
md"""
---
$\textbf{MÁQUINAS ELÉTRICAS DE CORRENTE CONTÍNUA}$

$\text{EXERCÍCIO 13}$ 

$\colorbox{Bittersweet}{\textcolor{white}{\textbf{Motores CC: curvas características}}}$
---
"""

# ╔═╡ ed44a647-2ed8-47f3-84d0-3efde79cf276
md"""
# Exercício 13. Dados:
"""

# ╔═╡ ed4846d5-70d2-4deb-9a4a-41cdc8c99bdd
md"""
**Considere um motor de corrente contínua, com a seguinte chapa de características:**
"""

# ╔═╡ 3e9c0345-f00d-4eb9-b4cb-15524c7ff950
Pᵤ, Uₙ, nₙ, ηₙ = 17e3, 250, 1200, 0.85 				# W, V, rpm, efficiency

# ╔═╡ 1301d1ad-89e8-4282-ab35-1a6b8214bea0
Rᵢ, Rₛ, Rd, Ns, Nd = 0.6, 0.1, 200, 12, 3000 		# Ω, Ω, Ω, turns, turns

# ╔═╡ 1a427cf6-b2d3-4d9b-9cb5-4682d5f49869
begin
	nmag=1200 # rotational speed of the no-load characteristic, rpm
	Iex=[0,0.0132,0.03,0.033,0.067,0.1,0.133,0.167,0.2,0.233,0.267,0.3,0.333,0.367,0.4,0.433,0.467,0.5,0.533,0.567,0.6,0.633,0.667,0.7,0.733,0.767,0.8,0.833,0.867,0.9,0.933,0.966,1,1.033,1.067,1.1,1.133,1.167,1.2,1.233,1.267,1.3,1.333,1.367,1.4,1.433,1.466,1.5]
	E₀=[5.40, 6.67,13.33,16,31.3,45.46,60.26,75.06,89.74,104.4,118.86,132.86,146.46,159.78,172.18,183.98,195.04,205.18,214.52,223.06,231.2,238,244.14,249.74,255.08,259.2,263.74,267.6,270.8,273.6,276.14,278,279.74,281.48,282.94,284.28,285.48,286.54,287.3,287.86,288.36,288.82,289.2,289.38,289.57,289.69,289.81,289.95]
	plot(Iex, E₀, title="E₀=f(Iₑₓ), n=1200rpm", xlabel = "Iₑₓ (A)", ylabel="E₀ (V)", ylims=(0,300), framestyle = :origin, minorticks=10, label=:none, linewidth=2)
end

# ╔═╡ 8bde3ad9-2d03-4557-ab50-a89ac8e834a3
aside((md"""
!!! nota
	No enunciado original não é considerada a existência de reacção magnética do induzido, $$(ΔE=0\rm V)$$.  
	No entanto, na versão *notebook* para que se possa verificar a influência de $$ΔE$$, nas características de funcionamento do motor CC, para os diferentes tipos de excitação, uma curva de $$ΔE=f(I_i)$$ é considerada como uma opção de análise."""), v_offset=100)

# ╔═╡ e2fc78d6-480b-4fe0-b844-0d4329c0d572
md"""
# 💻 Influência de $$ΔE$$ 
"""

# ╔═╡ 61238dc4-3c9d-4b59-9486-501988806c27
md"""
Análise considerando queda de tensão devido à reação magnética do induzido, $$ΔE\:?\:\:$$ $(@bind YN Select([0 => "Não", 1 => "Sim",]))
"""

# ╔═╡ c4d5e3f9-7808-48f6-8d33-05607d8e5a4e
begin
	Iᵢ=[0.0:15:120;]
	#Iᵢ=[0.0, 15, 30, 45, 60, 75, 90, 105, 120]
	ΔE=[0.0, 1.5, 4, 7.5, 12, 17, 23, 30.5, 40]*YN
	plot(Iᵢ, ΔE, title="ΔE=f(Iᵢ)", xlabel = "Iᵢ (A)", ylabel="ΔE (V)", xlims=(0,120), ylims=(0,40), framestyle = :origin, minorticks=5, label=:none, linewidth=2)
end

# ╔═╡ 54da2314-4fa8-483b-9627-9e454c110f3d


# ╔═╡ f6fcec56-b080-4016-baf0-0ab728f255f3
md"""
# a) $$R_c$$ para condições nominais
**Com o motor em excitação derivação, determine o valor do reóstato de campo, nas
condições nominais $$(U_n, I_n, n_n)$$**;
"""

# ╔═╡ d9e431c5-be62-40c8-b5d6-59d5808e4436
md"""
Para se ter a informação completa das condições nominais do motor, falta determinar o valor da corrente nominal, $$I_n$$.\
Da chapa de características do motor conhecem-se a potência útil (potência mecânica) e rendimento nominais, $$P_u$$ e $$\eta_n$$, respectivamente, o que permite obter a potência absorvida, $$P_{ab}=U_nI_n$$. Assim: 
"""

# ╔═╡ cde4847b-6c38-4bc6-a869-514774630c89
md"""
$$I_n=\frac{P_n}{\eta U_n}$$
"""

# ╔═╡ 1c70002d-e3fb-4d81-b0f9-ed00d69173ff
Iₙ = Pᵤ / (ηₙ * Uₙ);

# ╔═╡ 5b4c1912-126d-4fe8-87c5-f65b299f3642
md"""
Calculando obtém-se $$I_n=$$ $(Iₙ)A
"""

# ╔═╡ d8d6a6e9-df8d-47d2-832a-0d2126ce760e
md"""
A velocidade, $$n$$, é dependente do fluxo magnético, $$kϕ_0$$, que por sua vez depende da corrente de excitação, $$I_d$$ e da característica magnética da máquina.\
Assim, a imagem do fluxo magnético presente na máquina é dada pela a força contra-electromotriz de vazio do motor, $$E_0^{'}$$:
"""

# ╔═╡ 0ff562ff-7af2-4749-87f5-8766cb695893
md"""
$$E_0^{'}=E^{'}+ΔE$$
Sendo a  a força contra-electromotriz efectiva, $$E^{'}$$, dada por:\
"""

# ╔═╡ cf0f089a-1901-4ad1-8fe9-b9028679b109
md"""
$$E^{'}=U-R_iI_i$$
"""

# ╔═╡ de954f1d-a3ac-4830-acd0-85e64afdf0cd
# computational method of querying the ΔE(Ii) curve, by interpolating the data using Pkg Dierckx.jl
begin
	ΔE_int = Spline1D(Iᵢ, ΔE)  
	ΔEₙ = ΔE_int(Iₙ)
	ΔEₙ = round(ΔEₙ, digits=1)
end;

# ╔═╡ 68969be8-0bee-4cca-85de-7a8d2aa35ee2
md"""
O valor de $$ΔE$$ para $$I_n$$, consultando a sua curva de q.d.t é: $$ΔE=$$ $(ΔEₙ)V.  
"""


# ╔═╡ 8f5b0bd5-7a65-4ba3-bdd1-7cc3128fa8d8
Eʼ = Uₙ - Rᵢ * Iₙ;

# ╔═╡ 7d6a01a4-4876-42dc-ab66-f7f736d41a32
Eʼ₀ₙ = Eʼ + ΔEₙ;

# ╔═╡ 0a35c6dc-0967-4f8a-9fff-904f9062eeab
md"""
Calculando as f.c.e.m., obtêm-se $$E^{'}=$$ $(Eʼ)V e $$E_0^{'}=$$ $(Eʼ₀ₙ)V.
"""

# ╔═╡ 9d82a20f-3a14-4796-88e9-e27720632bbd
md"""

Note que tomou-se a corrente do rotor aproximadamente igual à corrente absorvida, $$I_i\simeq I_n$$, sendo no entanto, $$I_i=I_n+I_d$$. Contudo, não se está a desprezar a corrente $$I_d$$, mas sim a q.d.t. em $$R_i$$ devido a $$I_d$$. Ou seja, $$R_iI_d\lll R_iI$$ para efeito de cálculo de $$E_0^{'}$$ e uma vez que $$I_d$$ ainda não está calculada.
"""

# ╔═╡ 04b517f9-ed9f-4a5d-929b-82b10de843b9
md"""
A característica magnética foi obtida à mesma velocidade inscrita na chapa de características da máquina, $$n_n$$, por conseguinte, obtém-se dela directamente a corrente de campo, $$I_d$$.
"""

# ╔═╡ cfc7844e-3974-46ef-a53a-ee6a1a85d7f3
# computational method of querying the ΔE(Ii) curve, by interpolating the data using Pkg Dierckx.jl
begin
	E₀ₙ = Eʼ₀ₙ  						# because they are at the same speed!
	Id_int = Spline1D(E₀, Iex)  
	Id = Id_int(E₀ₙ)
	Id = round(Id, digits=2)
end;

# ╔═╡ 71356175-ffe4-4c3a-a895-8a4be8713a44
md"""
Consultando a característica magnética a 1200rpm, verifica-se:
 $$E_0=$$ $(E₀ₙ)V $$\Rightarrow$$ $$I_d=$$ $(Id)A.
"""

# ╔═╡ d85a5505-1ab5-43d0-97ad-a0cb4a220c06
md"""
Assim, o reostato de campo para colocar o motor *shunt* nas condições nominais é dado por:
"""

# ╔═╡ 7c572ab7-2292-423c-b611-68573b289265
md"""
$$R_c=\frac{U_n}{I_d}-R_d$$
"""

# ╔═╡ 14ad0875-e27a-442e-81e9-29d1abaeac17
begin
	Rc = Uₙ / Id - Rd
	Rc = round(Rc, digits=1)
end;

# ╔═╡ 50022e39-c2f4-455f-8d26-7c9246190b11
md"""
Calculando, obtém-se $$R_c=$$ $(Rc)Ω
"""

# ╔═╡ 4bac08e5-7a7a-496f-8d67-aa2bc4b10236
md"""
> Poderá então observar as diferenças de cálculo relativas à presença de q.d.t. devido à reacção magnética do induzido, ou seja, uma máquina com pólos auxiliares (caso mais frequente), conduz a $$ΔE \neq 0$$V, variável em função da corrente do induzido. No caso de uma máquina com pólos auxiliares e enrolamentos de compensação, a reacção magnética do induzido estará compensada e assim tem-se:
"""

# ╔═╡ 5abe64cf-9291-48d6-bf60-7335551ee791
md"""
$$ΔE=0 \Rightarrow E_0^{'}=E^{'}$$
"""

# ╔═╡ ac32afe0-e30f-402e-995e-8b0cacf8af10


# ╔═╡ 4989ff81-ac16-446c-8d8a-e3cb9e5950b6
md"""
# b) Motor shunt
**Utilizando o reóstato de campo calculado na alínea anterior, determine as características de velocidade, binário e mecânica deste motor (excitação derivação);**
"""

# ╔═╡ 1d458a5a-545f-4ab6-900b-9d84ebbaf51d
md"""
> Na resolução computacional para o **motor de excitação derivação**, as grandezas calculadas estão identificadas como: k$$ϕ$$₀₁, n₁, E₁, ω₁, Td₁
"""

# ╔═╡ d25759bf-6e81-439c-a2c9-c19704379437
begin
	kϕ₀₁ = E₀ₙ / nmag
	kϕ₀₁ = round(kϕ₀₁, digits=3)
end;

# ╔═╡ 4652d9e4-e2c6-47c4-93d1-1e360ffb7e57
md"""
Tomando o valor calculado de $$R_c=$$ $(Rc)Ω, resulta $$I_d=$$ $(Id)A, o que permite calcular o fluxo magnético da máquina em vazio, $$kϕ₀$$, que no motor de excitação derivação permanece constante.  
Assim, $$kϕ₀=$$ $(kϕ₀₁)V/rpm
"""

# ╔═╡ 4629c049-8882-4823-bdea-93e3d70cc901
md"""
A determinação da característica de velocidade $$n=f(I)$$ ou $$n=f(I_i)$$, uma vez que $$I_i\simeq I$$, consiste em sucessivamente realizar o cálculo da velocidade do motor para diferentes valores de corrente:  
"""

# ╔═╡ ea81ca51-dccc-4187-b788-7ed64716e698
md"""
$$n=\frac{U-R_iI_i+\Delta E}{k\phi_0}$$ com $$n$$ em rpm, $$\Delta E=f(I_i)$$ e $$k\phi_0=$$constante, em V/rpm.
"""

# ╔═╡ 6030b931-51a0-42fc-9b74-5635b590e6f5
# Speed curve:
begin
	I = 0:1:1.5*Iₙ
	Ii = I .- Id
	ΔEᵢ = ΔE_int(Ii)
	n₁ = (Uₙ .- Rᵢ*Ii .+ ΔEᵢ) / kϕ₀₁
end;

# ╔═╡ d47a90f0-f8bc-44d0-b71c-c0bc59d0d23c
md"""
Similarmente, a característica de binário, $$T=f(I)$$ ou $$T=f(I_i)$$, podendo $$T$$ ser o binário desenvolvido, $$T_d$$, ou o binário útil, $$T_u$$, atendendo que: $$T_d=T_u+T_p$$, consiste em sucessivamente realizar o cálculo do binário para diferentes valores de corrente:  
"""

# ╔═╡ 3c921729-6534-4eac-abb0-4eb362295b91
md"""
$$T_d=\frac{E^{'}}{ω}I_i\:\:\:;\:\:\:ω=\frac{2πn}{60}$$ com $$ω$$ em rad/s.
"""

# ╔═╡ 4da7f391-e3bf-4e12-aa6b-a7ef5e45d3b9
# Torque curve:
begin
	Eʼ₁ = Uₙ .- Rᵢ * Ii
	ω₁ = 2π .* n₁ / 60
	Td₁ = (Eʼ₁ ./ ω₁) .* Ii
end;

# ╔═╡ df3609ef-80f2-464a-b522-f289ea9344b4


# ╔═╡ f499659c-b042-4002-bb27-980daf8502d4
md"""
# c) Motor compound
**Idem, com excitação composta em longa derivação aditiva e subtrativa. Representar as características nos mesmos gráficos para comparação;**
"""

# ╔═╡ 72a079e6-0c41-4c50-9ee2-838d5cc60c85
md"""
No motor de excitação composta, o fluxo magnético depende da contribuição das forças magnetomotrizes de ambos os enrolamentos de excitação e da forma como estes estão ligados entre si (de forma aditiva ou subtractiva):
"""

# ╔═╡ 58e9df34-7471-4942-ac06-2505f52875f2
md"""
$$I_{ex}N_d=I_dN_d\pm I_sN_s$$
sendo $$I_s$$ a corrente que percorre o enrolamento de excitação série.
"""

# ╔═╡ f305c434-9d0c-497d-8335-bf25aa80e915
md"""
Assim, $$I_{ex}$$ é a corrente de campo que representa o fluxo total da máquina, sendo obtida por:
"""

# ╔═╡ 0ce81a6e-965c-4dc0-b9f3-f8c09143460e
md"""
$$I_{ex}=I_d \pm \frac{N_s}{N_d}I_s$$
"""

# ╔═╡ 1cd42258-7583-4288-9c6d-4d47facb69e1
md"""
Assim, a característica de velocidade para o motor de excitação composta em longa derivação é obtida por cálculo sucessivo da velocidade do motor para diferentes valores de corrente, através de:  
"""

# ╔═╡ facb1900-1093-46c7-97b2-187b67e21294
md"""
$$n=\frac{U-(R_i+R_s)I_i+\Delta E}{k\phi_t}$$ com $$k\phi_t=k(\phi_d \pm 	\phi_s)$$, em V/rpm obtido através da característica magnética da máquina.
"""

# ╔═╡ 6aae7842-4889-4be6-bd1d-eab44c610af8


# ╔═╡ 7ad852d3-e3b8-4799-8aae-a52c1ebe34ac
md"""
> Na resolução computacional para o **motor de excitação composta aditiva**, as grandezas calculadas estão identificadas como: `Iex₂`, `E₀₂`, `kϕ₀₂`, `n₂`, `E₂`, `ω₂`, `Td₂`
"""

# ╔═╡ b4e5cbd1-c1c1-47e1-a8aa-8fc2ef628e87
begin
	Iex₂ = Id .+ (Ns / Nd) * Ii
	E₀_int1 = Spline1D(Iex, E₀)  # interpolation function to the no-load characteristic
	E₀₂ = E₀_int1(Iex₂) #EMF that contains the magnetic flux shunt + series
	kϕ₀₂ = E₀₂ / nmag
	n₂ = (Uₙ .- (Rᵢ + Rₛ) * Ii .+ ΔEᵢ) ./ kϕ₀₂
	Eʼ₂ = Uₙ .- (Rᵢ + Rₛ) * Ii
	ω₂ = 2π .* n₂ / 60
	Td₂ = (Eʼ₂ ./ ω₂) .* Ii
end;

# ╔═╡ 55397202-48ae-4a3d-a053-9f46e6638560


# ╔═╡ 1a154f27-cd9a-4de8-b850-599b5e810811
md"""
> Na resolução computacional para o **motor de excitação composta subractiva**, as grandezas calculadas estão identificadas como: `Iex₃`, `E₀₃`, `kϕ₀₃`, `n₃`, `ω₃`, `Td₃`
"""

# ╔═╡ 626c5cab-64e2-446c-9d38-f01dde099d3e
begin
	Iex₃ = Id .- (Ns / Nd) * Ii
	E₀₃ = E₀_int1(Iex₃) #EMF that contains the magnetic flux shunt - series
	kϕ₀₃ = E₀₃ / nmag
	n₃ = (Uₙ .- (Rᵢ + Rₛ) * Ii .+ ΔEᵢ) ./ kϕ₀₃
	ω₃ = 2π .* n₃ / 60
	# Note: Back-EMF assumes the same values as the previous situation:
	Td₃ = (Eʼ₂ ./ ω₃) .* Ii
end;

# ╔═╡ 1c659ae6-1b29-43a5-92f7-30b1f24c3696


# ╔═╡ 426c40b4-5fa1-4d8a-b03c-11f3008484f6
md"""
# d) Motor série
**Determinar as curvas características com o circuito de derivação desligado (motor série). Representar as características nos mesmos gráficos para comparação;**
"""

# ╔═╡ 8dfd7146-2e55-4ea0-8cf2-3557d89e96e1
md"""
> Na resolução computacional para o **motor de excitação série**, as grandezas calculadas estão identificadas como: Iex₄, E₀₄, k$$ϕ$$₀₄, n₄, ω₄, Td₄
"""

# ╔═╡ 4e4469c8-994d-42c6-b373-8f295768b8b0
begin
	Iex₄ = (Ns / Nd) * Ii
	E₀₄ = E₀_int1(Iex₄) #EMF that contains only series magnetic flux
	kϕ₀₄ = E₀₄ / nmag
	n₄ = (Uₙ .- (Rᵢ + Rₛ) *Ii .+ ΔEᵢ) ./ kϕ₀₄
	ω₄ = 2π .* n₄ / 60
	# Note: Back-EMF assumes the same values as the previous situation:
	Td₄ = (Eʼ₂ ./ ω₄) .* Ii
end;

# ╔═╡ a45ad7c2-2f83-4e04-bdaf-8dcc30a150f5
# Speed curves, plots:
begin
	plot(I, n₁, linewidth=2, title="Características de velocidade", xlabel = "I (A)", ylabel="n (rpm)",  framestyle = :origin, minorticks=5, label="shunt")
	plot!(I,n₂, linewidth=2, label="comp. aditivo")
	plot!(I,n₃, linewidth=2, label="comp. subtractivo", legend=:bottomleft)
	plot!(I,n₄, linewidth=2, label="série", xlims=(0,120), ylims=(0,3000))
end

# ╔═╡ 5b866db3-ddd6-4bfd-b027-761c07d6755c
# Torque curves, plots:
begin
	plot(I, Td₁, linewidth=2, title="Características de binário", xlabel = "I (A)", ylabel="Td (Nm)",  framestyle = :origin, minorticks=5, label="shunt")
	plot!(I,Td₂, linewidth=2, label="comp. aditivo")
	plot!(I,Td₃, linewidth=2, label="comp. subtractivo", legend=:topleft)
	plot!(I,Td₄, linewidth=2, label="série", xlims=(0,120), ylims=(0,250))
end

# ╔═╡ 326135bd-24e3-492d-a7d5-1a14f065e80f
# Mechanical curves, plots:
begin
	plot(Td₁, n₁, linewidth=2, title="Características mecânicas", ylabel = "n (rpm)", xlabel="Td (Nm)",  framestyle = :origin, minorticks=5, label="shunt")
	plot!(Td₂, n₂, linewidth=2, label="comp. aditivo")
	plot!(Td₃, n₃, linewidth=2, label="comp. subtractivo", legend=:topright)
	plot!(Td₄, n₄, linewidth=2, label="série", xlims=(0,250), ylims=(0,3000))
end

# ╔═╡ 66e32f84-8b2a-4a3d-81fe-16437ecc3c18


# ╔═╡ 60db00b7-c78b-4c26-9530-c62fcfd1bfd2
md"""
# e) 💻 MI: variação $$n=f(I)$$ 
**Considere o motor com excitação independente (MI), Uexc = 240V , com o reóstato de campo calculado na alínea a). Explicite a variação da característica de velocidade nas situações:**
1. **aumento de tensão do induzido;**
2. **diminuição do reóstato de campo;**
3. **aumento da resistência adicional.**
"""

# ╔═╡ 4fdea2ae-3bf8-42cd-bf6f-411eaf8223c3
md"""
> Na resolução computacional para o **motor de excitação separada**, as grandezas calculadas estão identificadas como: `Ui`, `Iex5`, `E₀₅`, `kϕ₀₅`, `ΔEᵢᵢ`, `n₅`, `ω₅`, `Td₅`
"""

# ╔═╡ 36295cf6-19ba-4240-9806-745ec0bfdccd
md"""
| $\qquad$Tensão do induzido$\qquad$  | $\qquad$Reóstato de campo$\qquad$ | $\qquad$Resistência adicional$\qquad$ |
|:---:|:---:|:---:|
| $$U_i\:\: (\rm V)$$ | $$R_c\:\: (\rm \Omega)$$ | $$R_{ad}\:\: (\rm \Omega)$$ |
| $(@bind Ui PlutoUI.Slider(150:1:350, default=250.0, show_value=true)) | $(@bind Rc1 PlutoUI.Slider(0*Rc:0.01*Rc:2.5*Rc, default= Rc, show_value=true)) | $(@bind Rad PlutoUI.Slider(0:0.1:1.5, default=0.0, show_value=true))
"""

# ╔═╡ e648310c-8172-4cf0-ab72-f40229ba2577
begin
	Uexc = 240
	Iex₅ = Uexc /(Rc1 + Rd)
	E₀₅ = E₀_int1(Iex₅) 				#EMF for separately excited
	kϕ₀₅ = E₀₅ / nmag
	ΔEᵢᵢ = ΔE_int(I)
	n₅ = (Ui .- (Rᵢ + Rad) *I .+ ΔEᵢᵢ) ./ kϕ₀₅
	Eʼ₅ = Ui .- (Rᵢ + Rad) * I
	ω₅ = 2π .* n₅ / 60
	Td₅ = (Eʼ₅ ./ ω₅) .* Ii
end;

# ╔═╡ 4919a95d-cd66-401c-af76-6155087462a3
# Speed curve vs. variation of Ui, Rc1 and Rad; plots:
begin
	plot(I, n₅, ylims=(0,3000),linewidth=2, framestyle = :origin, title="Variação da característica de velocidade", label=:none, xlabel = "I (A)", ylabel="n (rpm)", minorticks=5, xlims=(0,120))
end

# ╔═╡ 8ad59666-3801-44a3-b26a-197a8f60db02
aside((md"""
!!! tip "Informação"
	
	Apresenta-se uma alínea f) idêntica à alínea anterior, mas considerando a característica de binário:  

	👉 Arrastar para esta alínea os _sliders_,  $U_i,$ $R_c$ e $R_{ad}$ para observar os efeitos sobre a característica de binário.
"""), v_offset=100)

# ╔═╡ f417c5f6-0a1f-4d60-b30f-2b9695d048f9
md"""
# f) 💻 MI: variação $$T=f(I)$$ 
"""

# ╔═╡ babc5b0b-3263-47d5-bd33-56917ece1e6b
md"""
**Considere o motor com excitação independente (MI), Uexc = 240V , com o reóstato de campo calculado na alínea a). Explicite a variação da característica de binário nas situações:**
1. **aumento de tensão do induzido;**
2. **diminuição do reóstato de campo;**
3. **aumento da resistência adicional.**
"""

# ╔═╡ 49cc56bc-bd1e-4e07-9d9c-0ccfaa92e7b0
# Torque curve vs. variation of Ui, Rc1 and Rad; plots:
begin
	plot(I, Td₅, ylims=(0,250),linewidth=2, framestyle = :origin, title="Variação da característica de binário", label=:none, xlabel = "I (A)", ylabel="Td (Nm)", minorticks=5, xlims=(0,120))
end

# ╔═╡ 9aa6487a-1d1b-4b2d-9da5-4302a282d4f5
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

# ╔═╡ 0835d195-7b73-4da2-bd99-a0adb9e893e8
md"""
# *Notebook*
"""

# ╔═╡ 06a35d2a-9f74-4e85-8292-6f35431c91dc
md"""
Documentação das bibliotecas Julia utilizadas:  [Dierckx](https://github.com/kbarbary/Dierckx.jl), [Plots](http://docs.juliaplots.org/latest/), [PlutoUI](https://featured.plutojl.org/basic/plutoui.jl), [PlutoTeachingTools](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html).
"""

# ╔═╡ c430ff11-614a-4c3c-bbc7-58903b30df07
begin
	version=VERSION
	md"""
*Notebook* desenvolvido em `Julia` versão $(version).
"""
end

# ╔═╡ 87c62aa6-caee-45a8-b146-be3d11fbc0e4
TableOfContents(title="Índice")

# ╔═╡ 38319731-adfe-4ac8-8004-6270d7752e1c
aside((md"""
!!! info "Informação"
	No índice deste *notebook*, os tópicos assinalados com "💻" requerem a participação do estudante.
"""), v_offset=-100)

# ╔═╡ 49030da5-cd46-4d7d-8f29-703a4b1c7509
md"""
|  |  |
|:--:|:--|
|  | This notebook, [DCmotors.jl](https://ricardo-luis.github.io/me-2/DCmotors.html), is part of the collection "[_Notebooks_ Computacionais Aplicados a Máquinas Elétricas II](https://ricardo-luis.github.io/me-2/)" by Ricardo Luís. |
| **Terms of Use** | All narrative and visual content is shared under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)), while the Julia code snippets are released under the [MIT License](https://www.tldrlegal.com/license/mit-license).|
|  | $©$ 2022-2026 [Ricardo Luís](https://ricardo-luis.github.io/) |
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Dierckx = "39dd38d3-220a-591b-8e3c-4c3a8c710a94"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Dierckx = "~0.5.4"
Plots = "~1.41.7"
PlutoTeachingTools = "~0.4.7"
PlutoUI = "~0.7.83"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.13.0"
manifest_format = "2.1"
project_hash = "28d1b248ade775add295ecdc82b240bba5888b7e"

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

[[deps.Dierckx]]
deps = ["Dierckx_jll"]
git-tree-sha1 = "7da4b14cc4c3443a1afc64abee17f4fcb45ad837"
registries = "General"
uuid = "39dd38d3-220a-591b-8e3c-4c3a8c710a94"
version = "0.5.4"

[[deps.Dierckx_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3251f44b3cac6fec4cec8db45d3ab0bfed51c4d8"
registries = "General"
uuid = "cd4c43a9-7502-52ba-aa6d-59fb2a88580b"
version = "0.2.0+0"

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
# ╟─e227c53c-28a1-4d09-bf05-ba24236f613a
# ╟─d45dcd85-db5f-4f9e-8f67-a82df904e0dc
# ╟─ed44a647-2ed8-47f3-84d0-3efde79cf276
# ╟─ed4846d5-70d2-4deb-9a4a-41cdc8c99bdd
# ╠═3e9c0345-f00d-4eb9-b4cb-15524c7ff950
# ╠═1301d1ad-89e8-4282-ab35-1a6b8214bea0
# ╟─1a427cf6-b2d3-4d9b-9cb5-4682d5f49869
# ╟─8bde3ad9-2d03-4557-ab50-a89ac8e834a3
# ╟─e2fc78d6-480b-4fe0-b844-0d4329c0d572
# ╟─61238dc4-3c9d-4b59-9486-501988806c27
# ╟─c4d5e3f9-7808-48f6-8d33-05607d8e5a4e
# ╟─54da2314-4fa8-483b-9627-9e454c110f3d
# ╟─f6fcec56-b080-4016-baf0-0ab728f255f3
# ╟─d9e431c5-be62-40c8-b5d6-59d5808e4436
# ╟─cde4847b-6c38-4bc6-a869-514774630c89
# ╟─5b4c1912-126d-4fe8-87c5-f65b299f3642
# ╠═1c70002d-e3fb-4d81-b0f9-ed00d69173ff
# ╟─d8d6a6e9-df8d-47d2-832a-0d2126ce760e
# ╟─0ff562ff-7af2-4749-87f5-8766cb695893
# ╟─cf0f089a-1901-4ad1-8fe9-b9028679b109
# ╟─68969be8-0bee-4cca-85de-7a8d2aa35ee2
# ╠═de954f1d-a3ac-4830-acd0-85e64afdf0cd
# ╟─0a35c6dc-0967-4f8a-9fff-904f9062eeab
# ╠═8f5b0bd5-7a65-4ba3-bdd1-7cc3128fa8d8
# ╠═7d6a01a4-4876-42dc-ab66-f7f736d41a32
# ╟─9d82a20f-3a14-4796-88e9-e27720632bbd
# ╟─04b517f9-ed9f-4a5d-929b-82b10de843b9
# ╟─71356175-ffe4-4c3a-a895-8a4be8713a44
# ╠═cfc7844e-3974-46ef-a53a-ee6a1a85d7f3
# ╟─d85a5505-1ab5-43d0-97ad-a0cb4a220c06
# ╟─7c572ab7-2292-423c-b611-68573b289265
# ╟─50022e39-c2f4-455f-8d26-7c9246190b11
# ╠═14ad0875-e27a-442e-81e9-29d1abaeac17
# ╟─4bac08e5-7a7a-496f-8d67-aa2bc4b10236
# ╟─5abe64cf-9291-48d6-bf60-7335551ee791
# ╟─ac32afe0-e30f-402e-995e-8b0cacf8af10
# ╟─4989ff81-ac16-446c-8d8a-e3cb9e5950b6
# ╟─1d458a5a-545f-4ab6-900b-9d84ebbaf51d
# ╟─4652d9e4-e2c6-47c4-93d1-1e360ffb7e57
# ╠═d25759bf-6e81-439c-a2c9-c19704379437
# ╟─4629c049-8882-4823-bdea-93e3d70cc901
# ╟─ea81ca51-dccc-4187-b788-7ed64716e698
# ╠═6030b931-51a0-42fc-9b74-5635b590e6f5
# ╟─d47a90f0-f8bc-44d0-b71c-c0bc59d0d23c
# ╟─3c921729-6534-4eac-abb0-4eb362295b91
# ╠═4da7f391-e3bf-4e12-aa6b-a7ef5e45d3b9
# ╟─a45ad7c2-2f83-4e04-bdaf-8dcc30a150f5
# ╟─5b866db3-ddd6-4bfd-b027-761c07d6755c
# ╟─326135bd-24e3-492d-a7d5-1a14f065e80f
# ╟─df3609ef-80f2-464a-b522-f289ea9344b4
# ╟─f499659c-b042-4002-bb27-980daf8502d4
# ╟─72a079e6-0c41-4c50-9ee2-838d5cc60c85
# ╟─58e9df34-7471-4942-ac06-2505f52875f2
# ╟─f305c434-9d0c-497d-8335-bf25aa80e915
# ╟─0ce81a6e-965c-4dc0-b9f3-f8c09143460e
# ╟─1cd42258-7583-4288-9c6d-4d47facb69e1
# ╟─facb1900-1093-46c7-97b2-187b67e21294
# ╟─6aae7842-4889-4be6-bd1d-eab44c610af8
# ╟─7ad852d3-e3b8-4799-8aae-a52c1ebe34ac
# ╠═b4e5cbd1-c1c1-47e1-a8aa-8fc2ef628e87
# ╟─55397202-48ae-4a3d-a053-9f46e6638560
# ╟─1a154f27-cd9a-4de8-b850-599b5e810811
# ╠═626c5cab-64e2-446c-9d38-f01dde099d3e
# ╟─1c659ae6-1b29-43a5-92f7-30b1f24c3696
# ╟─426c40b4-5fa1-4d8a-b03c-11f3008484f6
# ╟─8dfd7146-2e55-4ea0-8cf2-3557d89e96e1
# ╠═4e4469c8-994d-42c6-b373-8f295768b8b0
# ╟─66e32f84-8b2a-4a3d-81fe-16437ecc3c18
# ╟─60db00b7-c78b-4c26-9530-c62fcfd1bfd2
# ╟─4fdea2ae-3bf8-42cd-bf6f-411eaf8223c3
# ╠═e648310c-8172-4cf0-ab72-f40229ba2577
# ╟─36295cf6-19ba-4240-9806-745ec0bfdccd
# ╟─4919a95d-cd66-401c-af76-6155087462a3
# ╟─8ad59666-3801-44a3-b26a-197a8f60db02
# ╟─f417c5f6-0a1f-4d60-b30f-2b9695d048f9
# ╟─babc5b0b-3263-47d5-bd33-56917ece1e6b
# ╟─49cc56bc-bd1e-4e07-9d9c-0ccfaa92e7b0
# ╟─9aa6487a-1d1b-4b2d-9da5-4302a282d4f5
# ╟─0835d195-7b73-4da2-bd99-a0adb9e893e8
# ╟─06a35d2a-9f74-4e85-8292-6f35431c91dc
# ╠═6b359fc5-ec8d-47ec-89ec-b1b214a37a82
# ╟─c430ff11-614a-4c3c-bbc7-58903b30df07
# ╠═87c62aa6-caee-45a8-b146-be3d11fbc0e4
# ╟─38319731-adfe-4ac8-8004-6270d7752e1c
# ╟─49030da5-cd46-4d7d-8f29-703a4b1c7509
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
