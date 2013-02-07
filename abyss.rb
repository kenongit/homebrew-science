require 'formula'

class Abyss < Formula
  homepage 'http://www.bcgsc.ca/platform/bioinfo/software/abyss'
  url 'http://www.bcgsc.ca/downloads/abyss/abyss-1.3.4.tar.gz'
  sha1 '763dc423054421829011844ceaa5e18dc43f1ca9'
  head 'https://github.com/sjackman/abyss.git'

  option 'disable-popcnt', 'do not use the POPCNT instruction'

  # Only header files are used from these packages, so :build is appropriate
  if build.head?
    depends_on 'autoconf' => :build
    depends_on 'automake' => :build
    depends_on 'multimarkdown' => :build
  end
  depends_on 'boost' => :build
  depends_on 'google-sparsehash' => :build
  depends_on MPIDependency.new(:cc)

  # strip breaks the ability to read compressed files.
  skip_clean 'bin'

  # Fix a compiler error on OS X 10.8 Mountain Lion.
  # This issue is fixed upstream:
  # https://github.com/sjackman/abyss/issues/13
  def patches
    DATA unless build.head?
  end

  def install
    system "./autogen.sh" if build.head?
    args = [
      '--disable-dependency-tracking',
      "--prefix=#{prefix}"]
    args << '--disable-popcnt' if build.include? 'disable-popcnt'
    system "./configure", *args
    system "make install"
  end

  def test
    system "#{bin}/ABYSS", "--version"
  end
end

__END__
diff --git a/Graph/ContigGraphAlgorithms.h b/Graph/ContigGraphAlgorithms.h
index 023a898..0eac936 100644
--- a/Graph/ContigGraphAlgorithms.h
+++ b/Graph/ContigGraphAlgorithms.h
@@ -329,7 +329,7 @@ size_t addComplementaryEdges(ContigGraph<DG>& g)
		if (!found) {
			add_edge(vc, uc, g[e], static_cast<DG&>(g));
			numAdded++;
-		} else if (g[e] != g[f]) {
+		} else if (!(g[e] == g[f])) {
			// The edge properties do not agree. Select the better.
			g[e] = g[f] = BetterDistanceEst()(g[e], g[f]);
		}
