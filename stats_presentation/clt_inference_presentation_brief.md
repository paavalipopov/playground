# Presentation Brief: Delving into the subject of Statistical Inference starting with the CLT as Backbone

**Scope:** Frequentist statistical inference, with the Central Limit Theorem (CLT) as the structural spine. Only a short probability refresher — no deep bedrock coverage. Most time on the CLT itself: everyday manifestations, when it holds, when it fails in theory but holds empirically, when it can fails in experiments. Everything downstream (tests, false-positive control, test selection) hangs off it.

---

## 1. The CLT as a story

**Introduce CLT with its sibling LLN** Explain the dufference between them.

**Demonstrate them both with dice.** Uniform (1 die) → triangle (2 dice) → visibly bell (3–4 dice).

**More real life examples:** E.g., deep learning:

- A neuron's preactivation $z = \sum_i w_i x_i$ is a sum of many iid weights → Gaussianizes by the CLT. What averages is the **signal**, not weight "quality" (no weight is good or bad at initialization).
- $\mathrm{Var}(z) \approx n\,\sigma_w^2\,\overline{x^2}$ grows with fan-in $n$ → set $\sigma_w^2 \propto 1/n$ (Xavier/Glorot), $2/n$ (He, for ReLU). Same $\sqrt{n}$ fingerprint as the standard error.

**Bridge to inference.** Every test needs the sampling distribution of its statistic under the null; the CLT hands you approximately normal/$t$ for free, without knowing the population. z-tests, t-tests, confidence intervals, inference on a proportion (a mean of 0/1s — de Moivre/Laplace), and regression coefficients all rest on it. p-values are computed against those curves. The $\sqrt{n}$ in the standard error is why quadrupling the data only halves the error, which drives every power and sample-size calculation. It also settles test selection: the CLT is *why* parametric tests are licensed, so where it stumbles (small $n$ + heavy skew, ordinal data) is where you reach for rank-based tests.

More ideas to consider including:
**Why is the bell curve everywhere?** 

**Forgetting the original distribution.** Average many independent, finite-variance copies of anything and the average's distribution is Gaussian, regardless of the original shape. Only the mean and variance survive into the limit; skew, lumps, and bounds are erased. Demonstrate with original distributions with different shapes (uniform, bimodal).

**Failure modes.** Infinite variance (the villain) and strong dependence (effective sample size collapses).
Examplify with Cauchy and introduce generalized CLT.

---


## 2. Demo: reconstructing a two-sample test from scratch

**Setup:** two samples; ask whether they come from the same distribution. Sample from Gaussians for illustration. Reinvent the test rather than invoking one. Let's denote random vars A and B, and their sample means $\bar A$ and $\bar B$. (update notation below to match it) 

**Framing refinement (state up front):** comparing means tests $H_0: \mu_1 = \mu_2$, which is *narrower* than "same distribution" — they coincide only for Gaussian data with equal variance. Variance and shape are separate questions (F-test / Levene for variance; Kolmogorov–Smirnov for the whole distribution). State the null carefully: not "the datasets are identical" but "drawn from a common distribution," whose observable consequence we choose to test is $\mu_1 - \mu_2 = 0$.

**Arc — one complication per step, each dissolved by the CLT or a consequence:**

1. **Each mean is Gaussian by the CLT:** $\bar A \sim N(\mu_a, \sigma_a^2/n_i)$. Exact for Gaussian data, approximate for anything (universality).
2. **Difference is random mvariable.** True $\mu_a, \mu_b$ are unobservable; we have $\bar A, \bar B$ and look at $D = \bar A - \bar B$. $D$ is *random* so we can expect CLT working here.
3. **Difference of independent Gaussians is Gaussian, and variances add:** $D \sim N\!\left(\mu_1 - \mu_2,\ \dfrac{\sigma_1^2}{n_1} + \dfrac{\sigma_2^2}{n_2}\right)$. Pause on: variances add under *subtraction* because independent noise compounds, never cancels.
4. **Impose the null:** $D \sim N\!\left(0,\ \dfrac{\sigma_1^2}{n_1} + \dfrac{\sigma_2^2}{n_2}\right)$. A test = the distribution of your statistic in the world where nothing is going on.
5. **Standardize → the two-sample z-test:** $Z = \dfrac{\bar X_1 - \bar X_2}{\sqrt{\sigma_1^2/n_1 + \sigma_2^2/n_2}} \sim N(0,1)$ under $H_0$. Two-tailed (a difference in either direction counts) — natural place for the one- vs two-tailed point.
6. **You don't know $\sigma$.** Plug in sample variances $s^2$ → the denominator now jitters too → the ratio follows Student's $t$ (heavier tails = the extra caution for unknown $\sigma$); $t \to$ normal as $n \to \infty$. The equal-variance assumption splits the path: pooled Student's $t$ ($n_1 + n_2 - 2$ df) vs Welch's $t$ (Satterthwaite df). **Choosing a test = choosing a variance assumption.**
7. **Payoff — permutation test as climax.** If the samples share a distribution, the labels "group 1/2" are meaningless: pool all values, reshuffle labels, recompute $\bar X_1 - \bar X_2$ ~10,000 times → that histogram *is* the null distribution, built with no theory. Overlay the analytic $N(0,1)$ / $t$ curve → **they coincide** → the CLT predicted the shape without simulation. The analytic test is revealed as the shortcut.
   - **Subtlety (ties to the paper):** the permutation null is *exactly* "same distribution" via label exchangeability, but the *statistic* (mean difference) decides which alternatives you can detect — near-zero power against equal-mean/different-variance. The null you test and the statistic you test it with are independent choices.

**Two illustrative runs (show both error types live):**
- **Null:** both samples $N(0,1)$, $n = 30$ → rejects ~5% of the time (false-positive rate made visible).
- **Alternative:** $N(0,1)$ vs $N(0.5,1)$ → usually rejects (power). Sweep the gap ($0.2, 0.5, 0.8$) or $n$ → power climbs, and the $\sqrt{n}$ in the standard error is visibly what drives it.

## 3. Case study — the fold-dependence paper (plugs into the inference section)

Zeng, Li, Zhang et al. 2026, bioRxiv preprint. 

**What it shows:** Cross-validation folds are dependent (training sets overlap; each test fold trains every other iteration). Paired t-test and Wilcoxon assume independence → underestimate variance → inflated false-positive rate (~19% for a single 10-fold run vs. nominal 5%, rising toward ~100% under repeated CV).

**Ideas to pull:**
1. Violating independence is often more damaging than violating normality.
3. Non-identifiability: one CV run gives 2 statistics (sample mean, sample variance) but 3 unknowns (true mean, variance, between-fold correlation). The SHARP fix forces independence by splitting into disjoint halves.
4. Rank tests are not a loophole — Wilcoxon fails here too.
5. An invalid test ≠ a false finding: point estimates stay valid; it's the uncertainty quantification (p-values, CIs) that's corrupted.

