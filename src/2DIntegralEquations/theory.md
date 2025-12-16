# 2D Electromagnetic Integral Equations
In this class we will study the problem of a scalar wace produced by a source in the presence of a 2D object $\Omega$ with boundary $\Gamma$ in free space, as illustrated in Figure 1.
Assume that both the source and the object are invariant in the $z$-direction, such that the problem can be treated as two-dimensional.
In the lecture we have already discussed the TM and TE case for this scenario.
Here we will summarize the main results.

<div style="text-align:center; margin:-20pt; padding:0;">
  <figure style="display:inline-block; text-align:center; margin:0; padding:0;">
    <div style="margin:0; padding:0; line-height:0;">
      <svg width="466" height="266" xmlns="http://www.w3.org/2000/svg" style="display:block; margin:0 auto; padding:0;">
          <defs>
            <marker id="arrowhead" markerWidth="5" markerHeight="5" refX="2.5" refY="2.5" orient="auto" markerUnits="strokeWidth">
              <path d="M 0 0 L 5 2.5 L 0 5 z" fill="white" />
            </marker>
          </defs>
          <!-- outer contour -->
          <path d="M520 120
                   C540 140, 560 170, 540 210
                   C520 250, 500 280, 460 300
                   C420 320, 380 325, 340 310
                   C300 295, 260 280, 240 250
                   C220 220, 210 170, 240 140
                   C270 110, 320 100, 380 110
                   C440 120, 480 110, 520 120 Z"
                fill="none" stroke="white" stroke-width="2" transform="scale(0.66)" />
          <text x="350" y="220" font-family="serif" font-size="30" fill="white" transform="scale(0.66)">Ω⁻</text>
          <text x="390" y="80" font-family="serif" font-size="30" fill="white" transform="scale(0.66)">Ω⁺</text>
          <text x="470" y="330" font-family="serif" font-size="22" fill="white" transform="scale(0.66)">Γ</text>
          <line x1="270" y1="120" x2="255" y2="90"
                stroke="white" stroke-width="2.6"
                marker-end="url(#arrowhead)"
                transform="scale(0.66)" />
          <text x="245" y="115" font-family="serif" font-size="20" fill="white" transform="scale(0.66)">n̂</text>
      </svg>
    </div>
    <figcaption style="color:white; font-style:italic; font-size:0.9em; margin-top:-25px; margin-bottom:0;">
      Figure 1: Two-dimensional object in free space.
    </figcaption>
  </figure>
</div>

## TM - Case
In the TM case, the $z$-component of the magnetic field $H_z$ is zero and the $z$-component of the electric field $E_z$ satisfies the 2D Helmholtz equation
$$\nabla^2 E_z + k^2 E_z = 0\,, \quad \text{and}$$
on the boundary $\Gamma$:
$$\frac{\partial E_z}{\partial n} = \frac{k_t^2}{\text{j} \omega \varepsilon}(\gamma_{\hat{\tau}}\cdot \bm H_t)\,.$$

The representation theorem for the TM case reads
$$\gamma_{\text{D}}^\pm E_z = -\frac{k^2}{\text{j}\omega \varepsilon} \mathcal V [\gamma_{\hat{\tau}} \bm H_t] \pm \frac{[\gamma_\text{D}E_z]}{2} + \mathcal K[\gamma_\text{D} E_z] + \gamma_\text{D}^\pm E_z^\text{inc}$$

For the scattering of an infinite conducting cylinder with cross-section $\Omega^-$ and boundary $\Gamma$ we have
$$\text{In }\Omega^+:\quad E_z^+ = E_z^\text{inc} + E_z^\text{sca}\,, \quad \text{and}$$
$$\text{On }\Gamma:\quad E_z = 0\,.$$

With inserting 
$$\hat{\bm{n}} \times (\bm H_t^+ - \bm H_t^-) = \bm j$$
$$\Leftrightarrow (\bm H_t^+ - \bm H_t^-)\cdot (\hat{\bm{z}} \times \hat{\bm{n}}) = \bm j_z \Rightarrow -[\gamma_{\hat{\tau}}\bm H_t] = j_z$$
int the representation theorem and using 
$$\gamma_\text{D}^+ E_z^\text{sca} = -\gamma_\text{D}^+ E_z^\text{inc}$$
we obtain the Transversal Magnetic - Electric Field Integral Equation (TM-EFIE) with the unknown surface current density $j_z$:
$$\frac{k^2}{\text{j} \omega \varepsilon} \mathcal V j_z = -\gamma_\text{D}^+ E_z^\text{inc}$$

For the magnetic field we use the representation theorem with $\gamma_{\hat{n}}$:
$$\frac{k^2}{\text{j} \omega \varepsilon}\gamma_{\hat{\tau}}^+ \bm H_t = \frac{k^2}{\text{j} \omega \varepsilon}\left( \frac{-\mathcal I}{2} + \mathcal K'\right) [\gamma_{\hat{\tau}} \mathbf H_\text{t}] + \gamma_{\bm{\hat{n}}}E_z^{\text{inc}}$$
$$\Leftrightarrow \gamma_{\hat \tau}^+\bm H_t^{\text{sca}} = \left( \frac{\mathcal I}{2} - \mathcal K'\right) j_z$$
with the boundary conditions on $\Gamma$ this gives the transversal magnetic - magnetic field integral equation (TM-MFIE):
$$\left( \frac{\mathcal I}{2} - \mathcal K'\right) j_z = -\gamma_{\hat \tau}^+ \bm H_t^{\text{inc}}$$

