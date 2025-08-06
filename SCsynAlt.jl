### A Pluto.jl notebook ###
# v0.20.13

#> [frontmatter]
#> chapter = 3
#> section = 2
#> order = 2
#> image = "https://github.com/Ricardo-Luis/me-2/blob/bfc1477cd648078aaacad53992d420011a80c73d/images/card/SCsynAlt.png?raw=true"
#> layout = "layout.jlhtml"
#> date = "2024-12-11"
#> tags = ["lecture", "module4"]
#> title = "Curto-circuito simétrico de um alternador"
#> description = "Analisa-se detalhadamente o curto-circuito simétrico trifásico num alternador síncrono em vazio, combinando os fundamentos teóricos com simulação numérica para observar o transitório das correntes de curto-circuito do alternador. Através de parâmetros ajustáveis, como o ângulo de falha (α), os estudantes podem observar como as correntes de curto-circuito (AC e DC) evoluem, compreendendo o papel das reatâncias síncronas e das constantes de tempo. Inclui-se ainda a modelação do transitório da corrente rotórica, enriquecendo a análise com exemplos numéricos e comparações com dados técnicos"
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
TwoColumnWideLeft(md"`SCsynAlt.jl`", md"`Last update: 11·12·2024`")

# ╔═╡ c69f0608-04f7-4c40-aa9f-6a400d353d80
md"""
---
$\textbf{MÁQUINAS ELÉTRICAS SÍNCRONAS TRIFÁSICAS}$

$\textbf{Curto-circuito simétrico de um alternador em vazio}$

$\text{Análise do transitório}$
---
"""

# ╔═╡ 0ecffabc-9301-489e-b1a0-d0993ff4b404
md"""
Para este estudo do curto-circuito simétrico de um alternador em vazio foram utilizados os dados da máquina síncrona **G₁** da tabela 1 de [^1].\
Trata-se de um alternador síncrono de polos salientes de $25\rm MVA$, $13,8 \rm kV$ e considerou-se o seu funcionamento a $50 \rm Hz$.\
Sabem-se as reatâncias e as constantes de tempo que caracterizam o curto-circuito do alternador dados pelo fabricante:
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
 $X''_d$: reatância síncrona subtransitória

 $X'_d$: reatância síncrona transitória

 $X_d$: reatância síncrona segundo o eixo direto

 $T''_d$: constante de tempo subtransitória

 $T'_d$: constante de tempo transitória

 $T_a$: constante de tempo da armadura (estator)
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
O regime dinâmico da corrente de curto-circuito de um alternador síncrono é caracterizado por duas parcelas: uma parcela de corrente alternada (AC) e outra parcela de corrente contínua (DC).
"""

# ╔═╡ 83efce27-23e9-4a59-b79e-7cd3816788bb


# ╔═╡ 19e3e5f1-1a7e-4d7c-9e67-8cde3e743067
md"""
## Componente AC da corrente de curto-circuito
"""

# ╔═╡ f739b445-4928-4bac-8263-7be8b444392b
md"""
$\tag{1}
i_k^{\text{ac}}(t) = \sqrt{2} E_0 \left[ \left( \frac{1}{X_d''} - \frac{1}{X_d'} \right) e^{-\frac{t}{T_d''}} + \left( \frac{1}{X_d'} - \frac{1}{X_d} \right) e^{-\frac{t}{T_d'}} + \frac{1}{X_d} \right] \sin\left( \omega t + \alpha + \varphi + \theta_k \right)$

com:\
$\quad\quad k = \{1, 2, 3\}, \:\:\text{fases 1, 2 e 3 do alternador}$\
$\quad\quad E_0 \text{: força eletromotriz por fase}$\
$\quad\quad \omega = 2\pi f, \:\:\text{velocidade angular elétrica}$ \
$\quad\quad \alpha \text{: posição angular da tensão no momento que antecede o curto-circuito, } (t=0^-)$\
$\quad\quad \varphi = -\dfrac{\pi}{2}, \:\:\text{posição angular da corrente em relação à força eletromotriz}$\
$\quad\quad \theta_k = [0, \dfrac{-2π}{3}, \dfrac{2π}{3}],\:\:\text{posição angular relativa entre as fases 1, 2 e 3}$
"""

# ╔═╡ f3d503e8-9bf7-4010-9b9c-63ac7deed103


# ╔═╡ bc723dc3-455d-483b-86f8-ff93f4d8c751
md"""
A expansão da expressão de $(1)$, permite segmentar as parcelas nos períodos: subtransitório, transitório e estacionário, $(2)$:
"""

# ╔═╡ ee66c76e-7f66-40d5-9fea-85129dbeb9bf
md"""
$\begin{aligned}
i_k^{\text{ac}}(t) &= \underbrace{ \left( \frac{\sqrt{2} E_0}{X_d''} - \frac{\sqrt{2} E_0}{X_d'} \right) e^{-\frac{t}{T_d''}} 
\sin\left( \omega t + \alpha + \varphi + \theta_k \right) }_{\textbf{período subtransitório}} \:\: +\\[3mm]
&\quad \: + \: \underbrace{ \left( \frac{\sqrt{2} E_0}{X_d'} - \frac{\sqrt{2} E_0}{X_d} \right) e^{-\frac{t}{T_d'}} 
\sin\left( \omega t + \alpha + \varphi + \theta_k \right) }_{\textbf{período transitório}} \: + \\[3mm] 
&\quad \: + \: \underbrace{ \frac{\sqrt{2} E_0}{X_d} \sin\left( \omega t + \alpha + \varphi + \theta_k \right) }_{\textbf{período estacionário}}
\end{aligned}
\tag{2}$
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
Intervalo de tempo para cálculo das correntes de curto-circuito do alternador:
"""

# ╔═╡ 096119ef-8291-44a0-bcbc-3c8033c281f1
t = 0:0.001:5;

# ╔═╡ b573972e-a464-4a32-bc70-1e2a668c5825


# ╔═╡ 14dab71f-ea8d-4048-af48-7714165935a3
md"""
## Componente DC da corrente de curto-circuito
"""

# ╔═╡ a5b969d0-d700-427f-85b4-6f44b49090d5
md"""
$\tag{4}
i_k^{\text{dc}}(t) = \sqrt{2} \frac{E_0}{X_d''}
\sin\left( \alpha + \varphi + \theta_k \right) e^{-\frac{t}{T_a}}$
"""

# ╔═╡ f78f0bbe-7e44-4985-adc0-918d5bc7e997


# ╔═╡ cdc19447-0a40-49d5-a992-3848eb7f9f08
md"""
## Corrente de curto-circuito e envolventes
"""

# ╔═╡ f346e683-ff83-4fd7-9099-547a739535ef
md"""
A corrente de curto-circuito do alternador, $i_k(t)$, vem dada pela soma das componentes AC e DC, $(5)$:
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

# ╔═╡ 9b1a6a48-b110-4a07-b98b-430e8df6ca31
md"""
 $(@bind seletor MultiSelect(["i₁", "i₂", "i₃", "i₁ᵉⁿᵛ", "i₂ᵉⁿᵛ", "i₃ᵉⁿᵛ"]))  $$\quad\quad$$ tmin: $(@bind Xmin Slider(0:0.01:2.5, default=0, show_value=true)) $$\quad\quad$$ tmax: $(@bind Xmax Slider(0.1:0.01:5, default=5, show_value=true)) 

Posição angular da tensão, $$\alpha =$$ $(@bind α Slider(0:1:360, default=0, show_value=true))$$\degree$$ no momento que antecede o curto-circuito $$(t=0^-)$$ 


"""

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

	#gr()
	p = plot( xaxis=[Xmin, Xmax], yaxis=[-30e3, 30e3], 
			xlabel="\$ t\$ (s)", ylabel="Corrente(s) de curto-circuito (kA)", 
			yticks=(-30e3:10e3:30e3, [-30 -20 -10 0 10 20 30]), size=[700,400]
			)

	for (signal, name) in correntes
    	if name in seletor
        	plot!(t, signal, label=name, title="1 - Correntes de curto-circuito temporais do estator")
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

- as correntes de curto-circuito máximas: subtransitória, $I''$, transitória, $I'$, e de regime permanente, $I$;
- A corrente de curto-circuito máxima (incluindo a componente de corrente contínua), $I_{cc}^{máx}$;
- as reatâncias síncronas: subtransitória, $X''_d$, transitória, $X'_d$, e de regime permanente, $X_d$;
- constantes de tempo: subtransitória, $T''_d$, transitória, $T'_d$, e da armadura (estator), $T_a$.
"""

# ╔═╡ 8713ad11-8df8-4c6a-891d-32edf2dea948
md"""
## Extração da componente contínua
"""

# ╔═╡ d3683113-63a5-4d13-a5e0-26bb11ce5fda
md"""
A extração da componente DC da corrente de curto-circuito, $i_k^{dc}(t)$, corresponde a determinar o valor intermédio entre as envolventes da corrente de curto-circuito, $(7)$:
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
	#gr()
	plot(t, i₃ᵉⁿᵛᴾ, label="i₃ᵉⁿᵛᴾ", ylabel="Corrente de curto-circuito (kA)")
	plot!(t, i₃ᵉⁿᵛᴺ, label="i₃ᵉⁿᵛᴺ", yaxis=[-30e3, 30e3], size=[700, 400],
									 yticks=(-30e3:10e3:30e3, [-30 -20 -10 0 10 20 30]))
	plot!(t, i₃ᵈᶜ, label="i₃ᵈᶜ", lw=2, title="2 - Componente DC", xlabel="\$ t\$ (s)")
	plot!(t, (i₃ᵉⁿᵛᴾ .+ i₃ᵉⁿᵛᴺ)/2, label="cálculo i₃ᵈᶜ", lw=2)
end

# ╔═╡ 4f0b5c24-2bae-4710-ac87-52fd33dccb5f
md"""
Note-se que a componente DC da corrente de curto-circuito depende da posição angular, $\alpha$, da tensão (igual à força eletromotriz) no momento que antecede o curto-circuito. O resultado atual do gráfico 2 relativo à componente DC da corrente da fase 3, está apresentado para $\alpha=$ $(α)°.
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
begin
	#plotly()
	plot(t, i₃ᵉⁿᵛᴾ-i₃ᵈᶜ, label= "envolvente de i₃ᵃᶜ", lw=2, yaxis=[-30e3, 30e3],
						yticks=(-30e3:10e3:30e3,[-30, -20, -10, 0 ,10, 20, 30]),
						title="3 - Envolvente AC", xlabel="t (s)", legend=:bottomright,
						 ylabel="Corrente de curto-circuito (kA)", size=[700, 400])
end

# ╔═╡ c8eca392-f1d3-4ad1-a996-6ef11e6e6cc7
md"""
A representação da envolvente da componente AC da corrente de curto-circuito em um gráfico semilogarítmico permite evidenciar os decaimentos exponenciais, que aparecem como retas proporcionais na escala logarítmica:
"""

# ╔═╡ fe91d744-8fe1-4674-9fc8-a180a35c6f47
plot(t, i₃ᵉⁿᵛᴾ.- i₃ᵈᶜ, yscale=:log10, xlims=[0,5], label=:none, yticks=40, size=[700, 400],
		xlabel="t (s)", ylabel="Corrente de curto-circuito (A), escala log₁₀" ,title="4 - Gráfico semi-logarítmico ")

# ╔═╡ 51e6707f-2906-4921-b59e-73ae853b041c


# ╔═╡ f3dfed46-ddcb-4dc1-a654-682402a217f7
md"""
**Corrente de curto-circuito fase 3 (sem componente DC)**\
Representar sinusoide da corrente de curto-circuito? $(@bind z CheckBox())
"""

# ╔═╡ 637523c1-729f-49f9-ab11-3ce41e660a47
begin
	
	if z==:false 
		#plotly()
		plot(t, i₃ᵉⁿᵛᴾ-i₃ᵈᶜ, label= "envolvente período subtransitório", lc=:green, 							     lw=2, yaxis=[-15e3, 15e3],
							 yticks=(-15e3:5e3:15e3,[-15, -10, -5, 0 ,5, 10, 15]))
		plot!(t, i₃ᵉⁿᵛᴾ .- i₃ᵈᶜ.- √2E₀*((1/Xdʼʼ-1/Xdʼ)*exp.(-t/Tdʼʼ)), lw=2, xaxis=[0, 5],
			label= "envolvente período transitório + reg. permanente",legend=:bottomright, title="5 - Corrente de curto-circuito fase 3 (sem componente DC)", lc=:purple,
			xlabel="t (s)",  ylabel="Corrente de curto-circuito (kA)", size=[700, 400])	
	else
		plotly()
		plot(t, i₃ᵃᶜ, label="i₃ᵃᶜ", xticks=80)
		plot!(t, i₃-i₃ᵈᶜ, xticks=20, label="i₃ - i₃ᵈᶜ = i₃ᵃᶜ")
		plot!(t, i₃ᵉⁿᵛᴾ-i₃ᵈᶜ, label= "envolvente período subtransitório", lc=:green, 								  lw=2, yaxis=[-15e3, 15e3],
							  yticks=(-15e3:5e3:15e3,[-15, -10, -5, 0 ,5, 10, 15]))
		plot!(t, i₃ᵉⁿᵛᴾ .- i₃ᵈᶜ.- √2E₀*((1/Xdʼʼ-1/Xdʼ)*exp.(-t/Tdʼʼ)), lw=2, xaxis=[0, 5],
			label= "envolvente período transitório + regime permanente",legend=:bottomright, title="5 - Corrente de curto-circuito fase 3 (sem componente DC)", lc=:purple,
			xlabel="t (s)",  ylabel="Corrente de curto-circuito (kA)", size=[700, 400])	
	end
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
- Corrente máxima da corrente durante o regime transitório do curto-circuito, $I'=$ $(round(Iʼ/1000, digits=1)) $$\rm{kA}$$;
"""

# ╔═╡ c8e0da9b-c906-4aa7-a23b-9856075dccac
md"""
O valor máximo da corrente no período subtransitório, $I''$, obtém-se da envolvente AC, sem componente DC, em $(t=0 \rm{s})$: 
"""

# ╔═╡ 27e08a96-4433-4863-ae70-436f029acf4b
Iʼʼ= 14.786e3

# ╔═╡ a3638e5b-755a-4852-b9cd-532dbc326f85
md"""
- Corrente máxima da corrente durante o regime subtransitório do curto-circuito, $I''=$ $(round(Iʼʼ/1000, digits=1)) $$\rm{kA}$$;
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
As constantes de tempo subtransitória, transitória e da armadura são obtidas observando os decaimentos exponenciais da corrente a cerca de $36.8\%$ (ou seja, correspondente ao valor $e^{-1}$), das respetivas componentes com decaimento da corrente de curto-circuito: subtransitória, transitória e corrente contínua, [^3].
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
Assim, dado que a função exponencial associada à componente subtransitória não decresce até zero, mas até ao valor máximo da corrente de curto-circuito da componente transitória, $I'$, a corrente de curto-circuito correspondente ao decaimento de cerca de $36.8\%$ da componente subtransitória para obter a constante de tempo $T''_d$, vem dada por:
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
A constante de tempo da armadura é obtida pela análise do decaimento da componente DC da corrente de curto-circuito:
"""

# ╔═╡ 510600cd-3de4-4d2b-8296-f4723063c7c0
begin
	#plotly()
	plot(t, i₃ᵈᶜ, xticks=20, label="i₃ᵈᶜ",  size=[700, 400], lw=2,												  title="6 - Componente DC do curto-circuito",
				  yaxis=[-15e3, 15e3], yticks=(-15e3:5e3:15e3,[-15, -10, -5, 0 ,5, 10, 15]),
				  xlabel="t (s)",  ylabel="Componente DC (kA)")
end

# ╔═╡ 83f92eaa-02bb-4a46-a989-02d9ae4d0c74
md"""
Do gráfico 6, obtém-se sucessivamente:
"""

# ╔═╡ 1a2d4211-e42f-48a0-b1d7-6b62c7e6c026
I₃ᵈᶜ = i₃ᵈᶜ[1]

# ╔═╡ 12853183-f264-4015-b7f2-a4f2f0421755
ΔI₃ᵈᶜ =  I₃ᵈᶜ*exp(-1)

# ╔═╡ 2692d457-7f1e-4808-bb8f-3344387c374a
md"""
Consultando o valor do decaimento da corrente da componente DC no gráfico 6, obtém-se a contante de tempo da armadura:
"""

# ╔═╡ 57863975-5545-44db-ac02-9e5725eef09e
τₐ = 0.177

# ╔═╡ 263353e9-9829-418b-a98c-41d368a72b21
md"""
# Resumo de resultados
"""

# ╔═╡ f0bb7a7b-34ab-4b6d-8f88-e228ce2da6f4
md"""
Adicionalmente determina-se a corrente máxima da componente DC que pode ocorrer no curto-circuito em qualquer das fases, $i_k^{dc_{max}}(t=0)$, $(11)$:
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
O valor eficaz (máximo) que pode ocorrer no curto-circuito trifásico do alternador tem em conta as duas componentes AC e DC, $(13)$:

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

Por conseguinte, o resultado é meramente exemplificativo e não caracteriza o transitório da corrente no rotor da máquina síncrona de $25\rm MVA$ anteriormente analisada.

"""

# ╔═╡ a446230b-790d-4fa3-a45c-512a3fe34738
I𝚏₀ = 1;

# ╔═╡ 688f5861-4d7b-4587-bc6c-f8a0eab8b0af
Xdr, Rdr = 0.11, 0.05;

# ╔═╡ 7e5d9667-e397-434d-8297-d8ef4a34137e
Tdʼr = Xdr /(Rdr*2*π*f);

# ╔═╡ 311527ad-47a4-4bfa-8f1b-9b44e80cc4d5
md"""
$i_f(t) = I_{f0} + I_{f0} \left( \frac{X_d - X_d'}{X_d} \right) \left[ e^{-\frac{t}{T_d'}} - \left( 1 - \frac{T'_{dr}}{T_d''} \right) e^{-\frac{t}{T_d''}} - \left( \frac{T'_{dr}}{T_d''} \right) e^{-\frac{t}{T_a}} \cos\left( \omega t \right) \right]$
"""

# ╔═╡ 3a026946-a228-4269-a26e-e4825bae4c46
md"""
Da análise ao transitório da corrente rotórica, verifica-se que a componente DC da corrente de curto-circuito em cada fase gera uma componente alternada associada ao transitório da corrente do rotor. Essa componente AC apresenta um decaimento exponencial da sua amplitude, determinado pela constante de tempo da armadura, $T_a$.
"""

# ╔═╡ 3d349b98-3861-42bf-b489-272371d9dbb5
md"""
Da mesma forma a componente AC rotórica gera uma componente contínua nas correntes de curto-circuito dos enrolamentos do estator. 
"""

# ╔═╡ 087f40d5-5466-4a6b-9c47-26327d81a46b
md"""
## Cálculos auxiliares
"""

# ╔═╡ 7de0328a-5958-4dfa-a64b-7aa30722060f
i𝚏 = I𝚏₀ .+ I𝚏₀ * ((Xd-Xdʼ)/Xd)*(exp.(-t/Tdʼ) .- (1-Tdʼr/Tdʼʼ)*exp.(-t/Tdʼʼ) .- (Tdʼr/Tdʼʼ)*exp.(-t/Tₐ).*cos.(2π*f*t));

# ╔═╡ 6c0d42c4-9718-42ef-b315-efbc4901e849


# ╔═╡ 3d12d672-f0f3-4d7e-9325-8ff5b81f06ed
md"""
$\begin{aligned}
I_f^{\text{env}L}(t) &= I_{f0} + I_{f0} \left( \frac{X_d - X_d'}{X_d} \right) \left[ e^{-\frac{t}{T_d'}} - \left( 1 - \frac{T'_{dr}}{T_d''} \right) e^{-\frac{t}{T_d''}} - \left( \frac{T'_{dr}}{T_d''} \right) e^{-\frac{t}{T_a}} \right] \\
\\
I_f^{\text{env}H}(t) &= I_{f0} + I_{f0} \left( \frac{X_d - X_d'}{X_d} \right) \left[ e^{-\frac{t}{T_d'}} - \left( 1 - \frac{T'_{dr}}{T_d''} \right) e^{-\frac{t}{T_d''}} + \left( \frac{T'_{dr}}{T_d''} \right) e^{-\frac{t}{T_a}} \right]
\end{aligned}$
"""

# ╔═╡ 6500094b-fb25-4e6b-bbf7-0c2bd7dea34b
begin
	Ifᵉⁿᵛᴸ = I𝚏₀ .+ I𝚏₀ * ((Xd-Xdʼ)/Xd)*(exp.(-t/Tdʼ) .- (1-Tdʼr/Tdʼʼ)*exp.(-t/Tdʼʼ) .- (Tdʼr/Tdʼʼ)*exp.(-t/Tₐ))

	Ifᵉⁿᵛᴴ = I𝚏₀ .+ I𝚏₀ * ((Xd-Xdʼ)/Xd)*(exp.(-t/Tdʼ) .- (1-Tdʼr/Tdʼʼ)*exp.(-t/Tdʼʼ) .+ (Tdʼr/Tdʼʼ)*exp.(-t/Tₐ))
end;

# ╔═╡ 610d50f2-65ce-405f-954f-65fb9939160a


# ╔═╡ 4cf98440-4b8b-4512-bdfd-e2b79a4f643a
md"""
$I_f^{\text{ave}}(t) = \frac{I_f^{\text{env}H}(t) + I_f^{\text{env}L}(t)}{2}$

"""

# ╔═╡ 16ba8314-8677-4c2c-bd70-41d338818502
Ifᵃᵛᵉ=(Ifᵉⁿᵛᴴ+Ifᵉⁿᵛᴸ)/2;

# ╔═╡ 57188395-80e7-42be-b1f7-ab1dacdb4a40
begin
	plot(t, i𝚏, yaxis=[0, 2], xticks=15, yticks=40, title="Transitório da corrente rotórica")
	plot!(t, Ifᵉⁿᵛᴸ, xlabel="t (s)",  ylabel="corrente rotórica(pu)")
	plot!(t, Ifᵉⁿᵛᴴ, label="Ifᵉⁿᵛ")
	plot!(t, Ifᵃᵛᵉ, label="Ifᵉⁿᵛ", size=[700, 400])
end

# ╔═╡ d17f8a08-6fed-4305-a7f9-e26bb8338413


# ╔═╡ 1c6c0b6a-eb71-42f9-9ac8-1d5fe8339cbb


# ╔═╡ ad5f9fe4-c4a5-4b5a-a337-febe52733459
md"""
# Bibliografia
"""

# ╔═╡ e4da46c0-9ec7-4ee8-bbf4-3315a2302a5f
md"""
[^1] $\quad$Anastázia Margitová, Martin Kanálik, Michal Kolcun, *Verification of synchronous generator time constants given by manufacturers using the short-circuit current calculation*, Proc. of the 10ᵗʰ Int. Scientific Symposium on Electrical Power Engineering, ELEKTROENERGETIKA 2019, 16-18 September 2019, Stara Lesna, Slovakia, pp. 515 - 520.

[^2] $\quad$Ion Boldea, Lucian N. Tutelea, *Electric Machines -- Transients, Control Principles, Finite Element Analysis, and Optimal Design with* MATLAB®, 2ⁿᵈ Ed., CRC Press, 2022. 

[^3] $\quad$J. C. Das, *Power system analysis: short-circuit load flow and harmonics*, Marcel Dekker, 2002.
"""

# ╔═╡ a140ea41-5872-4f52-9d44-4e2314c9e216
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

# ╔═╡ 83a8151a-3259-48a9-8386-c55484a9f719
md"""
# _Notebook_
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
|  | $©$ 2022-2025 [Ricardo Luís](https://ricardo-luis.github.io) |
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
# ╟─19e3e5f1-1a7e-4d7c-9e67-8cde3e743067
# ╟─f739b445-4928-4bac-8263-7be8b444392b
# ╟─f3d503e8-9bf7-4010-9b9c-63ac7deed103
# ╟─bc723dc3-455d-483b-86f8-ff93f4d8c751
# ╟─ee66c76e-7f66-40d5-9fea-85129dbeb9bf
# ╟─bd3abdf6-c73f-424c-a8e5-a9bcc0b1bb7e
# ╟─02f68b6a-ef07-448e-9f8c-965496177e13
# ╟─9c3e9360-fc5a-48fb-8812-f508f0399de6
# ╟─1edc0d8b-0d59-416f-9808-ae3daf775356
# ╟─b55b6ee5-ff29-4c40-a958-b1c303994e3f
# ╠═096119ef-8291-44a0-bcbc-3c8033c281f1
# ╠═b1d68348-6466-458f-ac1a-7bcb77ba42d9
# ╟─b573972e-a464-4a32-bc70-1e2a668c5825
# ╟─14dab71f-ea8d-4048-af48-7714165935a3
# ╟─a5b969d0-d700-427f-85b4-6f44b49090d5
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
# ╟─9b1a6a48-b110-4a07-b98b-430e8df6ca31
# ╠═8f414dc5-216b-404f-b19b-fdd005f8316b
# ╟─9d630b0e-29f6-4dd3-9d24-7998d3166b70
# ╟─aa5795f2-ff47-49cc-a2fb-597ca71029f5
# ╟─3eeb83f5-bad8-4774-8416-3e630e343f3a
# ╟─8713ad11-8df8-4c6a-891d-32edf2dea948
# ╟─d3683113-63a5-4d13-a5e0-26bb11ce5fda
# ╟─5d11f908-4a59-48ed-9c70-8da0c7dcacf1
# ╟─8d621346-6d2d-48ca-b65e-90325f2c892e
# ╠═7123cde9-4efe-48fb-afcb-b04c7623b7da
# ╟─4f0b5c24-2bae-4710-ac87-52fd33dccb5f
# ╟─dd4635a7-373d-444f-b1e4-6095056f6527
# ╟─a4462b73-3282-4ac3-902c-99828ce936bb
# ╟─b8a00e75-0dc7-4052-9f71-efad992fb62d
# ╠═e65a7f5a-9722-46c7-a9ad-35640c7c48e4
# ╟─c8eca392-f1d3-4ad1-a996-6ef11e6e6cc7
# ╠═fe91d744-8fe1-4674-9fc8-a180a35c6f47
# ╟─51e6707f-2906-4921-b59e-73ae853b041c
# ╟─f3dfed46-ddcb-4dc1-a654-682402a217f7
# ╠═637523c1-729f-49f9-ab11-3ce41e660a47
# ╟─d05129bc-f313-4015-be2a-7baadade1d64
# ╟─6182cfe7-09e5-42b7-b099-d342491fc1ce
# ╟─f14324bf-571b-458b-8604-387c27508940
# ╟─42264626-5fe1-49c4-9b66-922a03421625
# ╠═c68c360e-bb24-4597-ab9b-88e481069889
# ╟─9aaf18f6-2d1e-4e96-9028-b7c7edfcaaed
# ╟─99e068c1-894d-4033-8f79-babfe50e0ba1
# ╠═15fc4a73-e39f-4254-a03b-3954becbbf92
# ╟─19d21193-40ca-4a40-a627-a1cd5ce3fca4
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
# ╠═510600cd-3de4-4d2b-8296-f4723063c7c0
# ╟─83f92eaa-02bb-4a46-a989-02d9ae4d0c74
# ╠═1a2d4211-e42f-48a0-b1d7-6b62c7e6c026
# ╠═12853183-f264-4015-b7f2-a4f2f0421755
# ╟─2692d457-7f1e-4808-bb8f-3344387c374a
# ╠═57863975-5545-44db-ac02-9e5725eef09e
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
# ╟─311527ad-47a4-4bfa-8f1b-9b44e80cc4d5
# ╠═57188395-80e7-42be-b1f7-ab1dacdb4a40
# ╟─3a026946-a228-4269-a26e-e4825bae4c46
# ╟─3d349b98-3861-42bf-b489-272371d9dbb5
# ╟─087f40d5-5466-4a6b-9c47-26327d81a46b
# ╠═7de0328a-5958-4dfa-a64b-7aa30722060f
# ╟─6c0d42c4-9718-42ef-b315-efbc4901e849
# ╟─3d12d672-f0f3-4d7e-9325-8ff5b81f06ed
# ╠═6500094b-fb25-4e6b-bbf7-0c2bd7dea34b
# ╟─610d50f2-65ce-405f-954f-65fb9939160a
# ╟─4cf98440-4b8b-4512-bdfd-e2b79a4f643a
# ╠═16ba8314-8677-4c2c-bd70-41d338818502
# ╠═d17f8a08-6fed-4305-a7f9-e26bb8338413
# ╟─1c6c0b6a-eb71-42f9-9ac8-1d5fe8339cbb
# ╟─ad5f9fe4-c4a5-4b5a-a337-febe52733459
# ╟─e4da46c0-9ec7-4ee8-bbf4-3315a2302a5f
# ╟─a140ea41-5872-4f52-9d44-4e2314c9e216
# ╟─83a8151a-3259-48a9-8386-c55484a9f719
# ╠═ccb548ca-265d-42fa-a64e-c6f0a29a17df
# ╟─d3557937-ae73-4939-9f78-ba2764e45735
# ╟─d82e7ab4-214d-4666-8d63-85ce21225cca
# ╠═f1d78f7a-570a-4983-b7b0-a1a56b706506
# ╟─98f9357c-6530-40cf-84e9-a30b756b3715
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
