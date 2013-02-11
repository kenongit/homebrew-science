require 'formula'

class Mira < Formula
  homepage 'http://sourceforge.net/apps/mediawiki/mira-assembler/'
  url 'http://downloads.sourceforge.net/project/mira-assembler/MIRA/stable/mira-3.4.1.1.tar.gz'
  sha1 '86bcf87f88296df4c3cce1d871e99a5bc3ca1dfd'

  depends_on 'boost'
  depends_on 'google-perftools'
  depends_on 'docbook'

  # Fix a compiler error on OS X 10.8
  # http://www.freelists.org/post/mira_talk/Type-mismatch-of-LexerInput-and-LexerOutput-PATCH
  def patches
    DATA if MacOS.version >= :mountain_lion
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-boost=#{HOMEBREW_PREFIX}"
    # Link with boost_system for boost::system::system_category().
    # http://www.freelists.org/post/mira_talk/Linking-requires-boost-system
    system "make LIBS=-lboost_system-mt install"
  end

  def test
    system "#{bin}/mira 2>&1 |grep -q MIRA"
  end
end

__END__
diff --git a/src/EdIt/parameters_flexer.cc b/src/EdIt/parameters_flexer.cc
index c64d67d..ec30813 100644
--- a/src/EdIt/parameters_flexer.cc
+++ b/src/EdIt/parameters_flexer.cc
@@ -1382,9 +1382,9 @@ void yyFlexLexer::switch_streams( std::istream* new_in, std::ostream* new_out )
 }
 
 #ifdef YY_INTERACTIVE
-int yyFlexLexer::LexerInput( char* buf, int /* max_size */ )
+size_t yyFlexLexer::LexerInput( char* buf, size_t /* max_size */ )
 #else
-int yyFlexLexer::LexerInput( char* buf, int max_size )
+size_t yyFlexLexer::LexerInput( char* buf, size_t max_size )
 #endif
 {
 	if ( yyin->eof() || yyin->fail() )
@@ -1411,7 +1411,7 @@ int yyFlexLexer::LexerInput( char* buf, int max_size )
 #endif
 }
 
-void yyFlexLexer::LexerOutput( const char* buf, int size )
+void yyFlexLexer::LexerOutput( const char* buf, size_t size )
 {
 	(void) yyout->write( buf, size );
 }
diff --git a/src/caf/caf_flexer.cc b/src/caf/caf_flexer.cc
index 7059a3b..1776fd7 100644
--- a/src/caf/caf_flexer.cc
+++ b/src/caf/caf_flexer.cc
@@ -2306,9 +2306,9 @@ void yyFlexLexer::switch_streams( std::istream* new_in, std::ostream* new_out )
 }
 
 #ifdef YY_INTERACTIVE
-int yyFlexLexer::LexerInput( char* buf, int /* max_size */ )
+size_t yyFlexLexer::LexerInput( char* buf, size_t /* max_size */ )
 #else
-int yyFlexLexer::LexerInput( char* buf, int max_size )
+size_t yyFlexLexer::LexerInput( char* buf, size_t max_size )
 #endif
 {
 	if ( yyin->eof() || yyin->fail() )
@@ -2335,7 +2335,7 @@ int yyFlexLexer::LexerInput( char* buf, int max_size )
 #endif
 }
 
-void yyFlexLexer::LexerOutput( const char* buf, int size )
+void yyFlexLexer::LexerOutput( const char* buf, size_t size )
 {
 	(void) yyout->write( buf, size );
 }
diff --git a/src/io/exp_flexer.cc b/src/io/exp_flexer.cc
index 1aa6fe0..26dc225 100644
--- a/src/io/exp_flexer.cc
+++ b/src/io/exp_flexer.cc
@@ -1420,9 +1420,9 @@ void yyFlexLexer::switch_streams( std::istream* new_in, std::ostream* new_out )
 }
 
 #ifdef YY_INTERACTIVE
-int yyFlexLexer::LexerInput( char* buf, int /* max_size */ )
+size_t yyFlexLexer::LexerInput( char* buf, size_t /* max_size */ )
 #else
-int yyFlexLexer::LexerInput( char* buf, int max_size )
+size_t yyFlexLexer::LexerInput( char* buf, size_t max_size )
 #endif
 {
 	if ( yyin->eof() || yyin->fail() )
@@ -1449,7 +1449,7 @@ int yyFlexLexer::LexerInput( char* buf, int max_size )
 #endif
 }
 
-void yyFlexLexer::LexerOutput( const char* buf, int size )
+void yyFlexLexer::LexerOutput( const char* buf, size_t size )
 {
 	(void) yyout->write( buf, size );
 }
diff --git a/src/mira/parameters_flexer.cc b/src/mira/parameters_flexer.cc
index a878ab1..621e14f 100644
--- a/src/mira/parameters_flexer.cc
+++ b/src/mira/parameters_flexer.cc
@@ -7325,9 +7325,9 @@ void yyFlexLexer::switch_streams( std::istream* new_in, std::ostream* new_out )
 }
 
 #ifdef YY_INTERACTIVE
-int yyFlexLexer::LexerInput( char* buf, int /* max_size */ )
+size_t yyFlexLexer::LexerInput( char* buf, size_t /* max_size */ )
 #else
-int yyFlexLexer::LexerInput( char* buf, int max_size )
+size_t yyFlexLexer::LexerInput( char* buf, size_t max_size )
 #endif
 {
 	if ( yyin->eof() || yyin->fail() )
@@ -7354,7 +7354,7 @@ int yyFlexLexer::LexerInput( char* buf, int max_size )
 #endif
 }
 
-void yyFlexLexer::LexerOutput( const char* buf, int size )
+void yyFlexLexer::LexerOutput( const char* buf, size_t size )
 {
 	(void) yyout->write( buf, size );
 }
