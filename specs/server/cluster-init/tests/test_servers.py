import unittest
import subprocess
import jetpack.config


def do_ping(port):
    '''The function actually asks zookeeper if all of the kafka brokers are registered'''
    p = subprocess.Popen(['redis-cli', '-p', port, 'ping'],
                         stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = p.communicate()
    return (p.returncode, stdout, stderr)


class TestRedisCluster(unittest.TestCase):

    def test_ping(self):
        slots = int(jetpack.config.get('redis.server_slots'))
        starting_port = 7000
        for slot in range(0, slots):
            port = starting_port + slot
            returncode, stdout, stderr = do_ping(str(port))
            self.assertTrue(returncode == 0, msg="Redis server not listening on port %s"
                            % str(port))
