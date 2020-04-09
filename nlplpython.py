##
# Using ConfigureMakePythonPackage as the template
# You should have received a copy of the GNU General Public License
# along with EasyBuild.  If not, see <http://www.gnu.org/licenses/>.
##
"""
EasyBuild support for Python packages that are configured with 'python configure/make/make install', implemented as an easyblock

@author:  Sabry Razick (University of Oslo)


"""
from easybuild.easyblocks.generic.configuremake import ConfigureMake
from easybuild.easyblocks.generic.pythonpackage import PythonPackage
from easybuild.tools.run import run_cmd


class nlplpython(ConfigureMake, PythonPackage):
    """
    Build a Python package and module with 'python configure/make/make install'.

    Implemented by using:
    - a custom implementation of configure_step
    - using the build_step and install_step from ConfigureMake
    - using the sanity_check_step and make_module_extra from PythonPackage
    """
    @staticmethod
    def extra_options():
        """Extra easyconfig parameters for Python packages being installed with python configure/make/make install."""
        extra = PythonPackage.extra_options()
        return ConfigureMake.extra_options(extra_vars=extra)

    def __init__(self, *args, **kwargs):
        """Initialize with PythonPackage."""
        PythonPackage.__init__(self, *args, **kwargs)

    def configure_step(self, *args, **kwargs):
        """Configure build using 'python configure'."""
        PythonPackage.configure_step(self, *args, **kwargs)
        cmd = ' '.join([self.cfg['preconfigopts'], self.python_cmd, self.cfg['configopts']])
        run_cmd(cmd, log_all=True)

    def build_step(self, *args, **kwargs):
        """Build Python package with 'make'."""
        return ConfigureMake.build_step(self, *args, **kwargs)

    def test_step(self, *args, **kwargs):
        """Test Python package."""
        PythonPackage.test_step(self, *args, **kwargs)

    def install_step(self, *args, **kargs):
        """Install with 'make install'."""
        ConfigureMake.install_step(self, *args, **kargs)
        return PythonPackage.install_step(self, *args, **kargs)

    def sanity_check_step(self, *args, **kwargs):
        """
        Custom sanity check for Python packages
        """
        #return PythonPackage.sanity_check_step(self, *args, **kwargs)
        print("OK")

    def make_module_extra(self):
        """Add extra Python package module parameters"""
        return PythonPackage.make_module_extra(self)
