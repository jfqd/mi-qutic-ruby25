if [[ ! -x /opt/qutic/bin/indexer ]]; then
  mkdir -p /opt/qutic/src
  cd !$
  curl -L -O https://download.qutic.com/src/sphinx/sphinx-0.9.9.tar.gz
  tar xf sphinx-0.9.9.tar.gz
  cd sphinx-0.9.9
  sed -i 's/T val = ExprEval ( this->m_pArg, tMatch );/T val = this->ExprEval ( this->m_pArg, tMatch );/' ./src/sphinxexpr.cpp
  LDFLAGS="-liconv" ./configure --prefix=/opt/qutic --with-mysql-lib=/opt/local/lib --with-mysql-includes=/opt/local/include/mysql
  make && make install
  cd ..
  rm -rf sphinx-0.9.9
else
  echo "sphinx already installed"
fi