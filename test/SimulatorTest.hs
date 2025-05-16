module SimulatorTest (main) where

import Test.HUnit
import Simulator.Simulator (simulate)

testSim :: Test
testSim = TestLabel "Simulation vide" $ TestCase (assertEqual "Basic" () (simulate undefined))

main :: IO Counts
main = runTestTT testSim