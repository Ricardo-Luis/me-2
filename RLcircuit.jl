### A Pluto.jl notebook ###
# v0.20.13

#> [frontmatter]
#> chapter = 0
#> section = 2
#> order = 2
#> image = "https://github.com/Ricardo-Luis/me-2/blob/08379161fb9595c9d9e3de44e217f288d86d0435/images/card/RLcircuit.png?raw=true"
#> title = "Diagramas vetoriais"
#> layout = "layout.jlhtml"
#> tags = ["preliminaries"]
#> date = "2024-09-09"
#> description = "Revisão de conceitos sobre notação complexa em circuitos AC e construção de diagramas vetoriais em Julia/Pluto."
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

# ╔═╡ 24742ef8-b976-4dd4-a176-fa0891d3165e
using PlutoUI, PlutoTeachingTools, Plots, NumericIO
#=
Brief description of the used Julia packages:
  - PlutoUI.jl, to add interactivity objects
  - PlutoTeachingTools.jl, to enhance the notebook
  - Plots.jl, visualization interface and toolset to build graphics
  - NumericIO.jl, support for formatting numeric data
=#

# ╔═╡ 5907d617-574a-4bc6-a710-f00682321c00
TwoColumnWideLeft(md"`RLcircuit.jl`", md"`Last update: 09·09·2024`")

# ╔═╡ f65b5561-c05d-4145-b828-a1f52f19a938
md"""
---
$\textbf{Grandezas complexas e fasores num circuito AC}$
$\colorbox{Bittersweet}{\textcolor{white}{Análise com diagramas vetoriais}}$
---
"""

# ╔═╡ 9acde771-2169-4ae3-9ebe-fa391588c5f3
md"""
# Âmbito

Este *notebook* apresenta dois objetivos a serem concretizados em simultâneo:

- serve de revisão a conceitos sobre a utilização de **notação complexa** em circuitos de corrente alternada (AC);
- e para introduzir a construção de **diagramas vetoriais** na linguagem de programação `Julia` usando a interface de trabalho `Pluto.jl`.

Sendo um documento computacional de revisão de conceitos de base em engenharia eletrotécnica, mas fundamentais na aprendizagem e aplicação de máquinas elétricas, o estudante poderá dividir a sua atenção nos dois objetivos propostos.
"""

# ╔═╡ b4777f70-8926-4595-b35f-7d9a5ba821cc


# ╔═╡ 63a79a06-a3b6-48a2-bd1c-d8d8663da070
md"""
# Números complexos em computação científica `Julia` 
"""

# ╔═╡ 4f173b81-6bbe-4ab6-bd7a-760e43ac1a7c
md"""
## Notação retangular
"""

# ╔═╡ 06cee7a0-6a2a-490a-ba28-5bdabfa859f6
md"""
Em programação `Julia` os números complexos são apresentados na forma retangular, como por exemplo: `2+3im`, sendo `im` a representação da unidade imaginária, ou seja:  
"""

# ╔═╡ 40201c93-3310-4b4c-9cde-97c02e8a7761
√(-1 + 0im) 	# to write the square root symbol "√", do: \sqrt + [TAB]

# ╔═╡ cbad77e0-2f99-49cd-bd10-d30d5874c612
2+3im - 3+2im

# ╔═╡ 59ee7138-3533-41aa-b28e-c26d99e5b7c5
md"""
Em engenharia eletrotécnica é usual utilizar `j` para designar a unidade imaginária. Assim pode-se redifinir:
"""

# ╔═╡ 58ada44d-294f-4542-8772-ff2db59f6f57
# imaginary unit defined in Julia Base for scientific and numerical	computation
j = Base.im 	 

# alternative:
# j(x) = (x)*im   # you can define a function j(x), with x being the imaginary quantity, but it must be enclosed in parentheses.

# ╔═╡ 69fae01b-8820-408e-b9b0-063a1b2c6d5e


# ╔═╡ 71fcdaa0-610d-4a29-a588-9ca491543ad7
md"""
## Fasores (notação polar): $$∠$$  
"""

# ╔═╡ 56bfaaf0-c510-4bf7-b99f-01fb28f7fef5
md"""
A utilização de fasores, ou seja, a representação de números complexos na forma polar, através do símbolo `∠` para a designação do ângulo do vetor, é também comummente utilizada em eletrotecnia, não sendo esta uma forma nativa na linguagem `Julia` para designar números complexos.

No entanto, em `Julia` é possível atribuir a símbolos, valores ou funções. Assim, ao símbolo `∠` atribuí-se a forma polar de um número complexo na forma `módulo∠(argumento)` com o `argumento` em graus, utilizando a seguinte instrução:
"""

# ╔═╡ cac8c4e4-b3f1-47e7-ae11-d440b8a1a196
∠(θ) = cis(deg2rad(θ))   # to write the angle symbol "∠", do: \angle + [TAB]

# ╔═╡ d28bb41e-9dbf-4b71-8d3c-b742fdf65057
md"""
A função `cis` corresponde à [Fórmula de Euler](https://pt.wikipedia.org/wiki/F%C3%B3rmula_de_Euler): $\quad e^{j\theta}=\cos\theta+j\sin\theta\quad$ aplicada à análise de números complexos.
"""

# ╔═╡ a3e6f2ce-4485-43f7-bbf6-5653f6c46676
md"""
Assim, torna-se possível a representação de fasores.
Exemplos:
"""

# ╔═╡ a6564805-78ff-4578-879b-23d5a524f9e9
begin
	I⃗ = 24∠(60)					# to write the vector symbol " I⃗ " do: I\vec + [TAB]
	I⃗ = round(I⃗, digits=1)
end

# ╔═╡ 118c5c66-ad94-4fb3-bc03-601ac82f1e4c
begin
	I⃗ₐ = 10∠(210);
	Iₐ = abs(I⃗ₐ)					# absolute value (magnitude) of the vector		

	# Arctangent of y/x wich results an angle between -π/2 and π/2:
		ϕₐ = atan(imag(I⃗ₐ)/real(I⃗ₐ))   

	# Option: use Julia function `angle` that gives the angle in radians of a complex number between -π and π
		# ϕₐ = angle(I⃗ₐ)

	# Option: use Julia funtion `atan` with 2 arguments, as `atan(y, x)`, is equivalent to the standard function atan2 to get the phase angle of a complex number between -π and π	
		# ϕₐ = atan(imag(I⃗ₐ), real(I⃗ₐ))
		
	ϕₐ = rad2deg(ϕₐ)
	I⃗ₐ, Iₐ, ϕₐ
end

# ╔═╡ 5cd95f64-ca23-496c-8ceb-88aa1787478b


# ╔═╡ 03f9ca10-d04e-44ca-bc5c-931b0aca09a8
md"""
## Funções trigonométricas
"""

# ╔═╡ c5fc5ea7-fadc-4d3b-877c-e4ba2a29865c
md"""
As funções trigonométricas em `Julia` são executadas seguindo o Sistema Internacional de Unidades, por conseguinte, os ângulos vêm na unidade radiano:
"""

# ╔═╡ 4880d829-a48a-484d-8a48-f197959fee2f
cosϕ₁ = 0.8

# ╔═╡ 3996720b-2e11-4bea-9eae-516b5afb63ed
ϕ₁ = acos(cosϕ₁)*180/π   # example of math conversion from radians to degrees

# ╔═╡ 2c1b8ff2-8cf5-45b1-ab38-d1f0b1692424
md"""
ou alternativamente utilizando a instrução: `rad2deg`:
"""

# ╔═╡ c802d6da-b36b-40af-b2f5-e10996b99587
begin
	cosϕ₂ = 0.8 
	ϕ₂ = acos(cosϕ₂)
	ϕ₂ = rad2deg(ϕ₂)
end

# ╔═╡ c3169e42-1803-4b9e-ba17-04465d178a6f
md"""
O mesmo raciocínio aplica-se a outras funções trigonométricas: `sin`, `asin`, `tan`, `atan`, ...
"""

# ╔═╡ c2a4ae6e-abf5-440e-ad77-7eb983b27f1c


# ╔═╡ 1e6e2a18-255e-4178-8450-05163c9c7c46
md"""
## 💻 Plano de Argand
"""

# ╔═╡ 7a0052e2-3d34-434d-8a8a-a91960e96c15
md"""
A biblioteca `Julia`, [`Plots.jl`](http://docs.juliaplots.org/latest/), adoptada nesta colectânea de *notebooks* para realização de gráficos, reconhece nativamente números complexos, representando-os num plano de Argand, também conhecido como plano complexo.

Assim, a utilização do plano de Argand para representação gráfica de grandezas vetoriais é realizado indicando cada vetor por um segmento de reta na forma `[origem, destino]`, em que a `origem` e `destino` são números complexos (em qualquer das suas formas: retangular, polar ou exponencial). A instrução `arrow` permite colocar o afixo do número complexo do lado desejado:
"""

# ╔═╡ 85778922-2a35-43d5-8764-d10cd9603a88
begin
	# Choose a scale factor, Kₐ, for the current:
	Kₐ = 1 
	plot([0, (Kₐ*Iₐ)∠(ϕₐ)], arrow=:closed, label="Iₐ∠ϕₐ", lw=2)

	# Below, remove the commentary symbol "#" to correct the graph size and x, y axis scales:
	plot!([0, 40∠(0)], arrow=:closed, lw=2, label="U∠0°", legend=:topright, 
		  size=(500,500), ylims=(-20,30), xlims=(0,50) 
	)
end

# ╔═╡ 2e31f596-02c4-40c2-875d-7cfd508f5478


# ╔═╡ 7e1672c4-8be7-4e08-9ef6-77d38e85dd67
md"""
# Problema 

\
Suponha uma fonte de tensão AC ideal monofásica com $U=100\rm{V}$ e frequência, $f=50\rm{Hz}$.  

Esta fonte de tensão alimenta uma carga linear do tipo RL série, com $R=10\Omega$ e $L=20\rm mH$.
Pretende-se dimensionar um condensador para compensar o fator de potência da carga.

**Desafio:**
 > **Criar um ambiente de análise interativo das tensões e correntes envolvidas no circuito AC descrito, representando as grandezas na formas temporal e vetorial.**
"""

# ╔═╡ 6c5e1063-19a2-4e72-85cb-b3fbd00d4a29


# ╔═╡ 0b765c6e-9012-4cb2-8cf2-ed05184d3220
md"""
## Dados
"""

# ╔═╡ 0eca339c-01fd-47ec-b14f-722ee300d068
md"""
Fonte tensão AC
"""

# ╔═╡ ff4982fd-062f-43da-86d6-56ec8d3e650e
U, f, θᵤ = 100.0, 50, 0 		# AC voltage, V; frequency, Hz; initial voltage phase angle, rad

# ╔═╡ 550357f9-92f8-484b-9966-65ad5ea592a7
md"""
Carga RL
"""

# ╔═╡ 8603c14f-88e9-44d1-aeeb-8bf9b9ca3a88
R, L = 10, 20e-3 				# electrical resistance, Ω; inductance, H

# ╔═╡ 1b0e1c7c-dd9b-493d-877d-6b29c95b20c7


# ╔═╡ 6deb6d95-1075-4e43-abdd-4fe44260c0ed
md"""
# Resolução
"""

# ╔═╡ 3a352a43-d9ac-4d3d-91cc-e37c8f2af810
md"""
## Impedância complexa
"""

# ╔═╡ cfc4fc55-5b33-415d-8ebe-92f8e714c3b8
md"""
A impedância complexa da carga RL, $\overline{Z}=R+jX_l$ onde $X_l$ é a reatância indutiva dada por: $X_l=2\pi f L$
"""

# ╔═╡ 87ecd0d4-cd20-4fa1-a03e-2b334e34f87b
Xₗ = 2π*f*L

# ╔═╡ 4ce5c9f4-78d9-4cf6-9ff7-dae285c5685a
begin
	Z⃗ = R + j*Xₗ
	
	Z = abs(Z⃗)
	Z = round(Z, digits=2)

	θ = atan(imag(Z⃗) / real(Z⃗))
	θ = rad2deg(θ)
	θ = round(θ, digits=2)
	
	Text("Z⃗ = $(Z)∠$(θ)°") 
end

# ╔═╡ 8484b73e-8ddc-4148-867d-a004a98b99c8


# ╔═╡ e39cac49-7fd8-46cf-b7c8-adb1206166de
md"""
## Fasores de tensão e corrente
"""

# ╔═╡ fc41d49a-72c9-4561-9621-ffbf2cf12595
begin
	U⃗ = (U)∠(θᵤ*180/π)
	
	I⃗ᵣₗ = U⃗ / Z⃗
	Iᵣₗ = abs(I⃗ᵣₗ)
	Iᵣₗ = round(Iᵣₗ, digits=2)
	θᵢ = atan(imag(I⃗ᵣₗ)/real(I⃗ᵣₗ))
	θᵢ_deg = rad2deg(θᵢ)
	θᵢ_deg = round(θᵢ_deg, digits=2)

	Text("U⃗ = $(U)∠$(θᵤ*180/π)°; I⃗ᵣₗ = $(Iᵣₗ)∠$(θᵢ_deg)°")
end

# ╔═╡ 1f8de210-e55c-4f24-8b3c-58d600e5e859


# ╔═╡ 487cb7d3-8263-46ed-840f-7cc4759741c4
md"""
## 💻 Representação gráfica
"""

# ╔═╡ d88b989e-617c-4278-9200-49833711df8f
begin
	ω = 2π*f  							# angular frequency, rad/s
	t=0:1e-5:0.04  						# time range, s
	
	u = √2*U*sin.(ω*t .+ θᵤ)   			# u(t), V
	iᵣₗ = √2*Iᵣₗ*sin.(ω*t .+ θᵢ)  		# i(t), A
end;

# ╔═╡ c8d3ebcd-e392-4f15-967e-c45e1f0b8e9a
md"""
Selecionar instante nos gráficos:$\quad$  $(@bind instante Slider(1:1:4001, default=1))
"""

# ╔═╡ 42ce0269-2cc9-4607-bbc8-5b9963ecad3d
begin
	# Voltage:
	h1 = plot(t, u, xlim=[0, 0.04], ylim=[-150, 150], label="u(t)", xlabel="t (s)", ylabel="u (V)", legend=:bottomleft, framestyle=:origin)
	
	# Current on secondary axis:
	plot!(twinx(), t, iᵣₗ, ylim=[-20, 20], lc=:red, xlim=[0,0.04], label="i(t)", ylabel="i (A)", size=(320,240), legend=:topright)

	# Markers of choosed instant:
	scatter!((t[instante], u[instante]), mc=:blue, ms=5, label=:none)
	scatter!(twinx(), (t[instante], iᵣₗ[instante]), ylim=[-20, 20], xlim=[0, 0.04],  mc=:red, ms=5, label=:none)
	vline!([t[instante]], lc=:black, ls=:dash, label=:none)

	# Voltage vector:
	h2 = plot([0, (U)∠(θᵤ*180/π+2*360*instante/4001)], arrow=:closed,  label=:none, ylim=[-100, 100], xlim=[-100,100], xticks=[], lw=2, lc=:blue, framestyle=:origin)

	# Current vector:
	plot!(twinx(), [0, (Iᵣₗ)∠(θᵢ*180/π+2*360*instante/4001)], arrow=:closed, label=:none, ylim=[-10, 10], xlim=[-10,10], xticks=[], lc=:red, size=(320,240),  framestyle=:origin, lw=2)

	# plot arrangement:
	TwoColumn(h1, h2)
end

# ╔═╡ a5e5db95-bd1f-4a7d-ad8b-47a9d7e9e5dc
aside((md"""
!!! nota "Observação"
	Seguindo a notação complexa, um fasor de uma onda sinusoidal é representado pela amplitude e argumento. No entanto, em eletrotecnia é comum trocar a amplitude pelo valor eficaz, porque os resultados que se pretendem obter são em valor eficaz e não em valor máximo (amplitude). 
	
	Este procedimento permite efetuar cálculos e obter resultados à semelhança da leitura de instrumentos de medida, em circuitos de corrente alternada, *e.g.*, voltímetros e amperímetros, onde as grandezas visualizadas são em valor eficaz.	
"""), v_offset=-450)

# ╔═╡ cffaa60e-1db6-435e-8826-8b620b939195
md"""
## Fator de potência, cosφ
"""

# ╔═╡ dc6d5c88-939b-4e58-9d79-17cb063a9227
md"""
**Cálculo através do desfasamento entre a tensão e a corrente, $\varphi$:**
"""

# ╔═╡ b41ae51e-2e4f-4151-bd32-b539f57156b7
begin
	φ = θᵢ - θᵤ
	round(rad2deg(φ), digits=1)
end

# ╔═╡ 203e1f4c-de09-471d-a5a0-de11590b68cc
begin
	cosφ = cos(φ)
	cosφ = round(cosφ, digits=3)
	
	if sign(φ)==-1
		md"cosφ = $(cosφ)(i)"
	elseif sign(φ)==0
		md"cosφ = 1"
	elseif sign(φ)==1
		md"cosφ = $(cosφ)(c)"
	end
end

# ╔═╡ 7f247c1d-22c4-49ba-804d-6b191104483d


# ╔═╡ 3bb413b1-fa75-44e0-9b66-ef9b274e4f12
md"""
**Cálculo atráves da potência complexa, $\overline{S}$:**

Genericamente pode escrever-se:

$\overline{S}=\overline{U} \: \overline{I^{\ast}}$
resultando no fasor:

$\overline{S}=S\angle \varphi$

ou usando a notação retangular:

$\overline{S}=P + j \: Q$
"""

# ╔═╡ b457c86a-65df-49d2-b4b1-2f46b6f99a5d
begin
	S⃗ = U⃗*conj(I⃗ᵣₗ)

	P = real(S⃗)
	Q = imag(S⃗)
	S = abs(S⃗)

	ϕ = atan(Q/P)
	ϕ_deg = rad2deg(ϕ)
	
	P, Q, S, ϕ_deg = round.([P Q S ϕ_deg], digits=2)
	
	Text("S⃗ = $(S)∠$(ϕ_deg)°; S⃗ = $(P) + j$(Q)") 
end

# ╔═╡ cf569de4-bb67-43c2-a2eb-e3842f6f7c00
md"""
Note que para designarmos corretamente o fator de potência, explicitando se é de carácter indutivo ou reativo, tem de se avaliar em que quadrante de funcionamento se encontra o fasor da potência, $\overline{S}$:
"""

# ╔═╡ fde903bf-0f19-4f6c-84f8-e1454269d10b
begin
	cosϕ = cos(ϕ)
	# cosϕ = P/S
	cosϕ = round(cosϕ, digits=3)
	
	if isapprox(ϕ, 0; atol=1e-9)
		md"cosφ = 1"
	elseif 0 < ϕ <= π/2    		
		md"cosφ = $(cosϕ)(i)"
	elseif -π/2 <= ϕ < 0 
		md"cosφ = $(cosϕ)(c)"
	end
end

# ╔═╡ 9d4b0fd3-f29c-437c-b354-d8b673145b66


# ╔═╡ c2634c14-1491-4982-815e-1899fa73e978
md"""
## Compensação do fator de potência
"""

# ╔═╡ 9450eb8e-6dae-41b0-91e5-d279baef30a1
md"""
Para melhorar o fator de potência deste circuito RL, uma solução é ligar em paralelo com a carga RL, um filtro passivo que cancele parcialmente ou totalmente a componente reativa imposta pela carga RL:
"""

# ╔═╡ b0957eb0-3712-4d62-bfa4-71796efe6a9f
html"""
<iframe frameborder="0" style="width:100%;height:324px;" src="https://viewer.diagrams.net/?tags=%7B%7D&highlight=FFFFFF&edit=_blank&layers=1&nav=1#R7Vptc9o4EP41fGzG79gfA6S9zuRmMuWul%2FQLo9gCdDWWTxYB%2ButvZUl%2BT0hSDEePDAFptV7J%2BzzalWQP7PFq%2B4mhdPk7jXA8sIxoO7AnA8vybBe%2BhWAnBY5hScGCkUiKzFIwJT%2BwEhpKuiYRzmqKnNKYk7QuDGmS4JDXZIgxuqmrzWlc7zVFC9wSTEMUt6V%2FkYgvpdR3jVL%2BGyaLpe7ZNFTLCmllZSJboohupCjXsW8G9phRymVptR3jWPhO%2B0Ua%2BvhMazEwhhP%2Bmgts53H6zV5Nvvy4vX%2F4mgXpzp5%2FUFaeULxWN6wGy3faAyklCcfs5gn6Ec40B%2FboCTNOwEm36BHHdzQjnNAE2h4p53QFCsXNGlCJULbEkaqgmCyEaoiFVRAs%2BSpumL1WOpym0lYqxrLaLgTFrnAMQDOhd8VwRjJOWVaUZpbokDBQkUPK6FoAMco4o98LDG2QzGOSflU9A304IokYUD7KtnO1p2CIeFsRKWd%2FwnSFOduBimp1hooJmvnWUNY3JY8sW4qWNQpp%2BirqLgrTJbpQUAC%2FAWzrvMEmSbQOc7B1aeZ2AtsEk1GO1JiDQ4FrejVwXT9ogWs6Rhtd2%2BgJXLuFJY4gkqkqZXxJFzRB8U0pBcesk6gAq9S5pQKLHKW%2FMec7FZbRmtM6hnhL%2BL26XJQfRPnKVbXJttI02VUqd5gRuO0CIQCC7e6rFWnJc1wtKI3ltV211jYXXYvYD9WEJlhKPhLh0Ly9TZlnKQHhg4V4fwQVzn6ROAzHQMKnelrpYoG69E7MxArhfBO8ERR%2FfoN%2FXsMiR2yBuTLSoFYxqvezzTnvUJKBHopnEtzsSoM8QlkqFxFzshU9j%2FKbyF3qjuAjuG2NjfzfhZscg8wUNSXXMlk367K6HnyAlvE0H8kfu3ykKHwbOV8fr4pYpJNRMLxyWxHLN9sBy%2B8rG3knCVg60JhnF2jUlJMTe3%2BWP3BAgttEu4qCmhjPxitT80YRzvMbq9NWfLNe0oeCHMFBo1hwypypy%2B%2FPmQX3KMThGvfMA3NveJwkZ9tGJwmOldUs55wXUW3A91Hk7AjhWMclxPC8lzkhSlFI8i1TUZyZHTuiXtYcll8Hz9Ub2%2BoeyejYI3l97ZH0odJLeFbmTBijLCNhHYT6dH%2FWTXtnRsUJbocPtOwnJ5DVnEBmw7dyprcmUNuQv8dQzzNRc%2Bf%2FA53t1FdEjvNO6FqGgiND94pzp18NuuAws84O9hjqG7qufb4Xc3F6SvOBlhh6%2F6ypbviQ5Yuda1AwvXSbQ6bbobSQv474uGMKKSUmsHsajj4PhpMZUS2qIxi47Etf1qAOZCNeJ4vMZmMaU7E0UhuzOSx7GqJWrm0m2BWJonyNt1kSjqeQQUWfG0izLUqKIaoVnukdKH82YretQ3CFxN4xjxhN97hs%2BBPYcOFC3hrYNSq4ltNxfHNcMngnCA3hhQ7d%2ByL31KGha6fUNxvgl8WXGFGuOv5r%2BcLvmxRfLtCr01O%2FHg%2B8ruP944If9A3%2B7QX8%2Bn5OLw6C9jnLUaHXh3T9QT%2B%2BQC%2Fd7zYeA1veiaF3W84%2F5gl6cWr%2BMKgcmr%2F9NYTG08Ff5tlgPy8r%2FOyzQaf55lr73YeX9N%2F6bBCq5Vt3Ur18ddG%2B%2BRc%3D"></iframe>
"""

# ╔═╡ b3c23dd5-ecb3-49b3-98e4-1f6d880f2025
md"""
Escolhendo o valor adequado do condensador poderá verificar no diagrama vetorial e no gráfico da evolução temporal das grandezas, a compensação do fator de potência, permitindo que a tensão e corrente da fonte de alimentação fiquem em fase:
"""

# ╔═╡ a4069d2f-5bca-45b7-95ea-0fbe59dc6a55
md"""
 $$C=\quad$$ $(@bind C Slider(0:0.1:350, default=0.1, show_value=true)) $$\:\:\mu F$$
"""

# ╔═╡ a4afa491-26ec-4655-8293-7774abb926f5
begin
	Xc = 1/(ω*C*1e-6)
	I⃗c = U⃗/(-j*Xc)
	I⃗ᵢ = I⃗ᵣₗ + I⃗c
end;

# ╔═╡ 5cbde964-3dac-4472-83d1-0231880beb54
begin
	Kᵢ=5
	plot([0, U⃗],arrow=:open, lw=4, label="U∠θᵤ", legend=:topright)
	plot!([0, (R*Iᵣₗ)∠(θᵢ*180/π)],arrow=:open, lw=5, lc=:grey; label="R*Iᵣₗ∠θᵢ°")
	plot!([(R*Iᵣₗ)∠(θᵢ*180/π), (R*Iᵣₗ)∠(θᵢ*180/π)+(Xₗ*Iᵣₗ)∠(θᵢ*180/π+90)],arrow=:open, lw=4, lc=:orange, label="Xₗ*Iᵣₗ∠(θᵢ°+90°)", size=(500,500), ylims=(-60,60), xlims=(-10,110))
	
	plot!([0, Kᵢ*I⃗ᵣₗ],arrow=:closed, lw=2, lc=:red, label="Iᵣₗ∠θᵢ°")
	plot!([Kᵢ*I⃗ᵣₗ, Kᵢ*I⃗ᵣₗ + Kᵢ*I⃗c], arrow=:none, lw=1, lc=:black, ls=:dash, label=:none)
	plot!([0, Kᵢ*I⃗c],arrow=:closed, lw=2, lc=:green, label="Ic∠90°")
	plot!([Kᵢ*I⃗c, Kᵢ*I⃗c + Kᵢ*I⃗ᵣₗ], arrow=:none, lw=1, lc=:black, ls=:dash, label=:none)
	plot!([0, Kᵢ*I⃗ᵢ],arrow=:closed, lw=2, lc=:black, label="Iᵢ∠φᵢ°")
end

# ╔═╡ 9e5b3036-c741-4aa7-8ccc-7b2ba33a44bc
md"""
A representação temporal da tensão e correntes representadas no circuito RL com a compensação do fator de potência, obtém-se através do cálculo das grandezas, $u(t)$, $i_i(t)$, $i_{rl}(t)$ e $i_c(t)$ e respetiva representação gráfica:
"""

# ╔═╡ b46be50d-b1ae-4b5e-b1de-eebbe2380c67
begin
	Iᵢ=abs(I⃗ᵢ)
	φᵢ=atan(imag(I⃗ᵢ)/real(I⃗ᵢ))
	iᵢ= √2*Iᵢ*sin.(ω.*t .+ φᵢ)
	
	Ic=abs(I⃗c)
	φc=atan(imag(I⃗c)/real(I⃗c))
	ic= √2*Iᵢ*sin.(ω.*t .+ π/2)	
end;

# ╔═╡ 24f7bb6e-54f3-4f84-95c9-4f11e8292b6a
begin
	plot(t, u, xlim=[0, 0.04], ylim=[-150, 150], label="u(t)", xlabel="t (s)", ylabel="u (V)", lw=2, legend=:bottomleft, framestyle=:origin)

	plot!(twinx(), t, iᵣₗ, ylim=[-20, 20], lc=:red, xlim=[0,0.04], label="iᵣₗ(t)", ylabel="i (A)", legend=:topright)
	
	plot!(twinx(), t, ic, ylim=[-20, 20], lc=:green, xlim=[0,0.04], label="ic(t)", legend=:bottomright)
	
	plot!(twinx(), t, iᵢ, ylim=[-20, 20], lc=:black, lw=2, xlim=[0,0.04], label="iᵢ(t)", legend=:topleft)
end

# ╔═╡ d7dd132a-522e-4e4b-9f87-975459e2d70c
md"""
Note-se que a escolha adequada do valor da capacidade do filtro passivo permite que a corrente de entrada do circuito, $i_i(t)$, fique em fase com a tensão de alimentação, $u(t)$, ou seja, $\cos \varphi=1$.
"""

# ╔═╡ bddd4830-a606-4e3f-a6a4-836d1c7ffe26


# ╔═╡ 372caab8-a5b0-46d9-856a-68384c5eecb3
md"""
### Solução analítica
"""

# ╔═╡ 1098adf7-b66e-4861-b9be-112115da8e84
md"""
Analiticamente, a solução do valor da capacidade do filtro passivo é fácil de obter, usando o valor da potência reativa imposta pelo circuito RL:
"""

# ╔═╡ 29057a6f-fb4b-4fae-8c79-0688a843d6b4
begin
	Xc₁ = U^2/Q
	C₁ = 1 /(ω * Xc₁)
end

# ╔═╡ fe413d93-1d07-468e-bf41-373f79a0e4a7
formatted(C₁, :ENG, ndigits=4) 

# ╔═╡ fcc379d4-d1f9-40f5-8d09-505c67b4de93
md"""
O que comprova o resultado obtido interativamente pela visualição gráfica (diagrama vetorial e/ou resposta temporal).
"""

# ╔═╡ ca97ea81-1ec3-41e7-bb4c-ad41b0528492
aside((md"""
!!! tip "Observação"
	O exercício apresentado tem como um dos objetivos o pretexto de exemplificar a elaboração computacional de diagramas vetoriais.

	A solução para a correcção do fator de potência ilustrada não tem em conta diversos aspetos técnicos que teriam de ser considerados numa situação real, tais como:
	- as cargas serem frequentemente não-lineares, o que pode colocar no circuito fenómenos de ressonância harmónica;
	- a fonte de alimentação não apresentar uma tensão sinusoidal perfeita;
	- ter em conta a impedância a montante, ou seja, a potência de curto-circuito da instalação.

	Assim, na prática, o dimensionamento de filtros passivos para compensação do fator de potência necessita de estudos avançados na área de [Qualidade de Energia Elétrica](https://www.isel.pt/mee/qualidade-de-energia-eletrica).

"""), v_offset=-720)

# ╔═╡ 3aaef504-b8a5-4214-973c-5b12c4cf4e4d
# Define alinhamento justificado para distribuir uniformemente o texto entre as margens:
html"""<style>
pluto-output p {
    text-align: justify;
}
</style>
"""

# ╔═╡ bc62a6e7-4d31-4ded-b4a6-15c785f60054
md"""
# *Notebook*
"""

# ╔═╡ 020a50a7-20d1-42aa-8e63-558d68380982
md"""
Documentação das bibliotecas Julia utilizadas: [PlutoUI](https://juliahub.com/docs/PlutoUI/abXFp/0.7.6/), [PlutoTeachingTools](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html), [Plots](http://docs.juliaplots.org/latest/), [NumericIO](https://github.com/ma-laforge/NumericIO.jl).
"""

# ╔═╡ bdb715da-523a-478d-a027-903820be78bf
begin
	version=VERSION
	md"""
*Notebook* desenvolvido em `Julia` versão $(version).
"""
end

# ╔═╡ b59dd96f-f332-4b22-829b-9712ba3cc673
TableOfContents(title="Índice")

# ╔═╡ a31ace2c-6133-4794-97b8-1e43fec0a9c2
aside((md"""
!!! info "Informação"
	No índice deste *notebook*, os tópicos assinalados com "💻" requerem a participação do estudante.
"""), v_offset=-100)

# ╔═╡ 2523215e-7d3c-4b25-b220-7e787e16c242
md"""
|  |  |
|:--:|:--|
|  | This notebook, [RLcircuit.jl](https://ricardo-luis.github.io/me-2/RLcircuit.html), is part of the collection "[_Notebooks_ Computacionais Aplicados a Máquinas Elétricas II](https://ricardo-luis.github.io/me-2/)" by Ricardo Luís. |
| **Terms of Use** | All narrative and visual content is shared under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)), while the Julia code snippets are released under the [MIT License](https://www.tldrlegal.com/license/mit-license).|
|  | $©$ 2022-2025 [Ricardo Luís](https://ricardo-luis.github.io) |
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
NumericIO = "6c575b1c-77cb-5640-a5dc-a54116c90507"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
NumericIO = "~0.3.3"
Plots = "~1.40.17"
PlutoTeachingTools = "~0.2.15"
PlutoUI = "~0.7.68"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.6"
manifest_format = "2.0"
project_hash = "51d0f626f03b84cd10bcadf1a8187e9c1e51c3da"

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

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "0037835448781bb46feb39866934e243886d756a"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.18.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

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
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "4e1fe97fdaed23e9dc21d4d664bea76b65fc50a0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.22"

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

[[deps.NumericIO]]
deps = ["Printf"]
git-tree-sha1 = "9cec2baefa68668bb3dc0959e3a546e7e1bf3796"
uuid = "6c575b1c-77cb-5640-a5dc-a54116c90507"
version = "0.3.3"

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
git-tree-sha1 = "ec9e63bd098c50e4ad28e7cb95ca7a4860603298"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.68"

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
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

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
git-tree-sha1 = "b81c5035922cc89c2d9523afc6c54be512411466"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.5"

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
# ╟─5907d617-574a-4bc6-a710-f00682321c00
# ╟─f65b5561-c05d-4145-b828-a1f52f19a938
# ╟─9acde771-2169-4ae3-9ebe-fa391588c5f3
# ╟─b4777f70-8926-4595-b35f-7d9a5ba821cc
# ╟─63a79a06-a3b6-48a2-bd1c-d8d8663da070
# ╟─4f173b81-6bbe-4ab6-bd7a-760e43ac1a7c
# ╟─06cee7a0-6a2a-490a-ba28-5bdabfa859f6
# ╠═40201c93-3310-4b4c-9cde-97c02e8a7761
# ╠═cbad77e0-2f99-49cd-bd10-d30d5874c612
# ╟─59ee7138-3533-41aa-b28e-c26d99e5b7c5
# ╠═58ada44d-294f-4542-8772-ff2db59f6f57
# ╟─69fae01b-8820-408e-b9b0-063a1b2c6d5e
# ╟─71fcdaa0-610d-4a29-a588-9ca491543ad7
# ╟─56bfaaf0-c510-4bf7-b99f-01fb28f7fef5
# ╠═cac8c4e4-b3f1-47e7-ae11-d440b8a1a196
# ╟─d28bb41e-9dbf-4b71-8d3c-b742fdf65057
# ╟─a3e6f2ce-4485-43f7-bbf6-5653f6c46676
# ╠═a6564805-78ff-4578-879b-23d5a524f9e9
# ╠═118c5c66-ad94-4fb3-bc03-601ac82f1e4c
# ╟─5cd95f64-ca23-496c-8ceb-88aa1787478b
# ╟─03f9ca10-d04e-44ca-bc5c-931b0aca09a8
# ╟─c5fc5ea7-fadc-4d3b-877c-e4ba2a29865c
# ╠═4880d829-a48a-484d-8a48-f197959fee2f
# ╠═3996720b-2e11-4bea-9eae-516b5afb63ed
# ╟─2c1b8ff2-8cf5-45b1-ab38-d1f0b1692424
# ╠═c802d6da-b36b-40af-b2f5-e10996b99587
# ╟─c3169e42-1803-4b9e-ba17-04465d178a6f
# ╟─c2a4ae6e-abf5-440e-ad77-7eb983b27f1c
# ╟─1e6e2a18-255e-4178-8450-05163c9c7c46
# ╟─7a0052e2-3d34-434d-8a8a-a91960e96c15
# ╠═85778922-2a35-43d5-8764-d10cd9603a88
# ╟─2e31f596-02c4-40c2-875d-7cfd508f5478
# ╟─7e1672c4-8be7-4e08-9ef6-77d38e85dd67
# ╟─6c5e1063-19a2-4e72-85cb-b3fbd00d4a29
# ╟─0b765c6e-9012-4cb2-8cf2-ed05184d3220
# ╟─0eca339c-01fd-47ec-b14f-722ee300d068
# ╠═ff4982fd-062f-43da-86d6-56ec8d3e650e
# ╟─550357f9-92f8-484b-9966-65ad5ea592a7
# ╠═8603c14f-88e9-44d1-aeeb-8bf9b9ca3a88
# ╟─1b0e1c7c-dd9b-493d-877d-6b29c95b20c7
# ╟─6deb6d95-1075-4e43-abdd-4fe44260c0ed
# ╟─3a352a43-d9ac-4d3d-91cc-e37c8f2af810
# ╟─cfc4fc55-5b33-415d-8ebe-92f8e714c3b8
# ╠═87ecd0d4-cd20-4fa1-a03e-2b334e34f87b
# ╠═4ce5c9f4-78d9-4cf6-9ff7-dae285c5685a
# ╟─8484b73e-8ddc-4148-867d-a004a98b99c8
# ╟─e39cac49-7fd8-46cf-b7c8-adb1206166de
# ╠═fc41d49a-72c9-4561-9621-ffbf2cf12595
# ╟─1f8de210-e55c-4f24-8b3c-58d600e5e859
# ╟─487cb7d3-8263-46ed-840f-7cc4759741c4
# ╠═d88b989e-617c-4278-9200-49833711df8f
# ╟─c8d3ebcd-e392-4f15-967e-c45e1f0b8e9a
# ╟─42ce0269-2cc9-4607-bbc8-5b9963ecad3d
# ╟─a5e5db95-bd1f-4a7d-ad8b-47a9d7e9e5dc
# ╟─cffaa60e-1db6-435e-8826-8b620b939195
# ╟─dc6d5c88-939b-4e58-9d79-17cb063a9227
# ╠═b41ae51e-2e4f-4151-bd32-b539f57156b7
# ╠═203e1f4c-de09-471d-a5a0-de11590b68cc
# ╟─7f247c1d-22c4-49ba-804d-6b191104483d
# ╟─3bb413b1-fa75-44e0-9b66-ef9b274e4f12
# ╠═b457c86a-65df-49d2-b4b1-2f46b6f99a5d
# ╟─cf569de4-bb67-43c2-a2eb-e3842f6f7c00
# ╠═fde903bf-0f19-4f6c-84f8-e1454269d10b
# ╟─9d4b0fd3-f29c-437c-b354-d8b673145b66
# ╟─c2634c14-1491-4982-815e-1899fa73e978
# ╟─9450eb8e-6dae-41b0-91e5-d279baef30a1
# ╟─b0957eb0-3712-4d62-bfa4-71796efe6a9f
# ╟─b3c23dd5-ecb3-49b3-98e4-1f6d880f2025
# ╟─a4069d2f-5bca-45b7-95ea-0fbe59dc6a55
# ╠═a4afa491-26ec-4655-8293-7774abb926f5
# ╟─5cbde964-3dac-4472-83d1-0231880beb54
# ╟─9e5b3036-c741-4aa7-8ccc-7b2ba33a44bc
# ╠═b46be50d-b1ae-4b5e-b1de-eebbe2380c67
# ╟─24f7bb6e-54f3-4f84-95c9-4f11e8292b6a
# ╟─d7dd132a-522e-4e4b-9f87-975459e2d70c
# ╟─bddd4830-a606-4e3f-a6a4-836d1c7ffe26
# ╟─372caab8-a5b0-46d9-856a-68384c5eecb3
# ╟─1098adf7-b66e-4861-b9be-112115da8e84
# ╠═29057a6f-fb4b-4fae-8c79-0688a843d6b4
# ╠═fe413d93-1d07-468e-bf41-373f79a0e4a7
# ╟─fcc379d4-d1f9-40f5-8d09-505c67b4de93
# ╟─ca97ea81-1ec3-41e7-bb4c-ad41b0528492
# ╟─3aaef504-b8a5-4214-973c-5b12c4cf4e4d
# ╟─bc62a6e7-4d31-4ded-b4a6-15c785f60054
# ╟─020a50a7-20d1-42aa-8e63-558d68380982
# ╠═24742ef8-b976-4dd4-a176-fa0891d3165e
# ╟─bdb715da-523a-478d-a027-903820be78bf
# ╠═b59dd96f-f332-4b22-829b-9712ba3cc673
# ╟─a31ace2c-6133-4794-97b8-1e43fec0a9c2
# ╟─2523215e-7d3c-4b25-b220-7e787e16c242
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
