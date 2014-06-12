
ROOTCFLAGS = `root-config --cflags`
ROOTLIBS   = `root-config --libs`

CXXFLAGS += -I. -Wall


%.o : %.c
	$(RM) $@
	$(CC) -c $(CFLAGS) -o $@ $<
	
%.o : %.cc
	$(RM) $@
	$(CXX) -c $(CXXFLAGS) -o $@ $*.cc


OBJS    = EarthDensity.o BargerPropagator.o mosc.o mosc3.o 


LIBBASE   = ThreeProb
VER       = 2.10
TAG       = 
LIBALIAS  = $(LIBBASE)$(TAG)
LIBNAME   = $(LIBALIAS)_$(VER)

lib3p     = lib$(LIBNAME).a


targets = $(lib3p) probRoot probLinear probAnalytic


$(lib3p) : $(OBJS)
	$(RM) $@
	ar clq $@ $(OBJS)
	ranlib $@
	

probRoot: probRoot.o $(lib3p) 
	$(RM) $@
	$(CXX) -o $@ $(CXXFLAGS) -L. $^ $(ROOTLIBS)


.PHONY: probRoot.o
probRoot.o: 
	$(CXX) -o probRoot.o $(ROOTCFLAGS) $(CXXFLAGS) -c probRoot.cc



probLinear: probLinear.o $(lib3p) 
	$(RM) $@
	$(CXX) -o $@ $(CXXFLAGS) -L. $^ $(ROOTLIBS)


.PHONY: probLinear.o
probLinear.o: 
	$(CXX) -o probLinear.o $(ROOTCFLAGS) $(CXXFLAGS) -c probLinear.cc


probAnalytic: probAnalytic.o $(lib3p) 
	$(RM) $@
	$(CXX) -o $@ $(CXXFLAGS) -L. $^ $(ROOTLIBS)


.PHONY: probAnalytic.o
probAnalytic.o: 
	$(CXX) -o probAnalytic.o $(ROOTCFLAGS) $(CXXFLAGS) -c probAnalytic.cc


	
.PHONY: all
all: $(targets)
	
	
.PHONY: clean
clean:
	$(RM) $(targets) *.o
	
emptyrule:: $(lib3p)

	
