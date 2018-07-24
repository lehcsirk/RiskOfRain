import requests
import time
import sys
import json
import webbrowser
import os
import pynput
from pynput.keyboard import Key, Controller

# Remaining Possible Improvements
# Add ability to decide how many tokens are transferred
# Check accounts to see if balance is high enough before initiating
# Reduce time it takes

####################################################################
#                           FUNCTIONS                              #
####################################################################

# Clears Terminal (MAC)
def clearOSX():
    os.system('cls' if os.name == 'nt' else 'clear')
    print("-3.0  Cleared the terminal.\n")

# Gets keys for each account
def getKey(name, path):
    r = requests.get(url2 + path)
    json_data = json.loads(r.text)
    counter = 0
    while True:
        if json_data['data'][counter]['friendlyName'] == name:
            key = json_data['data'][counter]['id']
            break
        else:
            counter += 1
        if counter > 4:
            print(name + " not found.")
            break
    return key

# Gets all keys
def getAllKeys():
    global alicePublicKey, bankPublicKey, bobPublicKey, jrPublicKey, sharedPublicKey, trustPublicKey
    alicePublicKey  = getKey("Alice", "people")
    bankPublicKey   = getKey("Bank", "people")
    bobPublicKey    = getKey("Bob", "people")
    jrPublicKey     = getKey("Jr.", "people")
    sharedPublicKey = getKey("Shared Account", "assets")
    trustPublicKey  = getKey("Trust", "assets")
    print('\n-0.5  Got all keys.\n')

# Prints all keys
def printAllKeys():
    print ("Alice:\t" + alicePublicKey)
    print ("Bank:\t" + bankPublicKey)
    print ("Bob:\t" + bobPublicKey)
    print ("Jr.\t" + jrPublicKey)
    print ("Shared:\t" + sharedPublicKey)
    print ("Trust:\t" + trustPublicKey)

# Gets hash for a transaction
def getTransactionHash(str):
    json_data = json.loads(str)
    hash = json_data['data']['hash']
    return hash

# Gets hash for a modification of purse owner
def getModifyHash(str):
    json_data = json.loads(str)
    hash = json_data['data']['transaction_hashes'][0]
    return hash

# Creates a scenario
def createScenario(name, type, active):
    load = {
                'scenario':
                {
                    'name': name,
                    'scenario_type': type,
                    'currently_active':active
                }
           }
    r = requests.post(url2 + "scenarios", json=load)
    print("-2.0  " + type + " \"" + name + "\" created.")
    print(r.status_code, r.reason)

# Opens browser of most recently created scenario
def openBrowser(tab):
    i = 1
    while True:
        r = requests.get(url1 + 'scenarios/' + str(i) + '/dashboard')
        if(r.status_code == 200):
            i += 1
        else:
            if i == 1:
                print (" 0.0  Unable to find a scenario")
                break
            else:
                webbrowser.open(url1 + 'scenarios/' + str(i-1) + '/dashboard')

                if(tab):
                    # Returns to previous window (terminal)
                    keyboard.press(Key.cmd)
                    time.sleep(0.00001)
                    keyboard.press(Key.tab)
                    keyboard.release(Key.cmd)
                    keyboard.release(Key.tab)

                print(" 0.0  Opened browser for Scenario " + str(i-1) + ".")
                break

# Sends tokens from key1 to key2
def sendAtoB(key1, key2, hash, mosaics, purse_mosaics, message,victim_mosaics,urlAddition):
    load = {
                'initiator':key1,
                'hash':hash,
                'message':message,
                'send':
                {
    	          'assets': [],
    	          'mosaics': mosaics,
    	          'purse_mosaics': purse_mosaics
                },
                'victim':key2,
                'receive':
                {
    	          'assets': [],
    	          'mosaics': victim_mosaics,
    	          'purse_mosaics': []
                }
            }
    r = requests.post(url2+urlAddition, json=load)
    print("\n"+message)
    print(r.status_code, r.reason)
    return r.text

# Modifies purse ownership
def modify(initiator, message, asset, new_cosigners, new_min_approvals, urlAddition):
    load = {
                'initiator': initiator,
                'message': message,
                'asset': asset,
                'new_cosigners': new_cosigners,
                'new_min_approvals': new_min_approvals
            }
    r = requests.post(url2+urlAddition, json=load)
    print("\n"+message)
    print(r.status_code, r.reason)
    return r.text

# Signs a transaction
def sign(transaction_hash, signer, urlAddition):
    load = {
                'transaction_hash': transaction_hash,
                'signer': signer
            }
    r = requests.post(url2+urlAddition, json=load)
    print(r.status_code, r.reason)

# Monitors account for emptiness at specific url
def monitor(account):
    start_time = time.time()
    while True:
        elapsed_time = time.time() - start_time
        if  account:
            r = requests.get(url = url2 + "people/" + account + "/partials")
            json_data = json.loads(r.text)
            if  json_data['data']['trades']:
                return True
                break
            if json_data['data']['modifies']:
                return True
                break
            if elapsed_time > 30:
                return False
                break
        else:
            r1 = requests.get(url = url2 + "people/")
            r2 = requests.get(url = url2 + "assets/")
            if r1.status_code == 200 and r2.status_code == 200:
                j1 = json.loads(r1.text)
                j2 = json.loads(r2.text)
                if j1['data'] and j2['data']:
                    return True
                    break
                if elapsed_time > 30:
                    return False
                    break

####################################################################
#                       SETS IMPORTANT VALUES                      #
####################################################################

# Sets URL (defaults to localhost)
if len(sys.argv) < 2:
    url2 = "http://localhost:4100/"
else:
    url2 = "http://" + sys.argv[1] + ":4100/"

# URL for opening browser
url1 = "http://localhost:4000/"

# tokenID is hardcoded (always the same for all mosaics)
tokenID = "8897661142964677655"

# Allows for alt-tab from browser back to terminal
keyboard = Controller()

####################################################################
#                           DEMO BEGINS                            #
####################################################################

# -3.0 Clears terminal window (MAC TESTED ONLY)
clearOSX()

# -2.0 Creates initial Bank Scenario
createScenario("Bank", "Bank / Trust", True)

# -1.0 Grabs keys
if(monitor(False)):
    print ('\n-1.0  Confirmed initial Scenario.')
    getAllKeys()
    #printAllKeys()
else:
    print('\n-1.0  Failed to confirm initial Scenario.')

#  0.0 Opens browser
openBrowser(True)

#  1.0 Alice to Shared
if(not monitor(alicePublicKey)):
    sendAtoB(alicePublicKey,sharedPublicKey,[],
    [{"id": tokenID, "amount": 0}],[],
    ' 1.0  Alice transferred tokens to Shared.',[],"trades")
else:
    print('\n 1.0  Transfer still awaiting signature.\n')

#  2.0 Shared to Jr. on Alice's behalf
if(not monitor(alicePublicKey)):
    sendAtoB(alicePublicKey, jrPublicKey,[],[],
    [
    	{
    		"purse": sharedPublicKey,
    		"mosaic": {"id": tokenID, "amount": 0}
    	}
    ],
    ' 2.0  Alice transferred tokens from Shared to Jr.',[],"trades")
else:
    print('\n 2.   Transfer still awaiting signature.\n')

#  3.0 Trust to Jr. on Bob's behalf (Multisig)
if(not monitor(bobPublicKey)):
    testHash = sendAtoB(bobPublicKey, jrPublicKey,[],[],
    [
    	{
    		"purse": trustPublicKey,
    		"mosaic": {"id": tokenID, "amount": 0}
    	}
    ],
    ' 3.0  Bob transferred tokens from Trust to Jr.',[],"trades")
else:
    print('\n 3.0  Transfer still awaiting signature.\n')

#  3.5 Capture signature needed from Bank or Alice and sign as Bank
if(monitor(bankPublicKey) or monitor(alicePublicKey)):
    print ('\n 3.5  Bank signed the transaction.')
    sign(getTransactionHash(testHash),bankPublicKey,"cosign")
else:
    print(' 3.5  Bank could not find transaction.')

#  4.0 Aggregate transfer from Alice and Trust to Jr. (Multisig)
if(not monitor(alicePublicKey)):
    testHash = sendAtoB(alicePublicKey, jrPublicKey,[],
    [{"id": tokenID, "amount": 0}],
        [
        	{
        		"purse": trustPublicKey,
        		"mosaic": {"id": tokenID, "amount": 0}
        	}
        ],
    ' 4.0  Alice transferred tokens from Alice and Trust to Jr.',
    [],"trades")
else:
    print('\n 4.0  Transfer still awaiting signature.\n')

#  4.5 Capture signature needed from Bank and sign as Bank
if(monitor(bankPublicKey)):
    print ('\n 4.5  Bank signed the transaction.')
    sign(getTransactionHash(testHash),bankPublicKey,"cosign")
else:
    print(' 4.5  Bank could not find transaction.')

#  5.0 Junior gets Trust (Multisig)
if(not monitor(bobPublicKey)):
    testHash = modify(bobPublicKey, ' 5.0   Jr. can control his Trust.',
    trustPublicKey, [jrPublicKey], 1, "modify")
else:
    print('\n 5.0   Transfer still awaiting signature.\n')

#  5.5 Capture signature needed from Bank or Bob and sign as Bank
if(monitor(bankPublicKey) or monitor(alicePublicKey)):
    print ('\n 5.5  Bank signed the transfer of Trust ownership.')
    sign(getModifyHash(testHash),bankPublicKey,"cosign")
else:
    print(' 5.5  Bank could not find transfer of Trust ownership.')

#  6.0 Trust to Jr. and demonstrate no signatures required
if(not monitor(jrPublicKey)):
    sendAtoB(jrPublicKey, jrPublicKey,[],[],
    [
    	{
    		"purse": trustPublicKey,
    		"mosaic": {"id": tokenID, "amount": 0}
    	}
    ],
    ' 6.0  Jr. transferred tokens from Trust.',
    [],"trades")
else:
    print('\n 6.0  Transfer still awaiting signature.\n')

####################################################################
#                           RESET DEMO                             #
####################################################################

#  7.0 Reset Trust
if (not monitor(jrPublicKey)):
    testHash = modify(bobPublicKey, ' 7.0  Reset Trust.',
    trustPublicKey, [alicePublicKey, bobPublicKey, bankPublicKey], 2, "modify")
else:
    print('\n 7.0  Could not reset Trust.')

#  7.5 Sign as Jr.
if(monitor(jrPublicKey)):
    print ('\n 7.5  Jr. signed the transfer of Trust ownership.')
    sign(getModifyHash(testHash),jrPublicKey,"cosign")
else:
    print('\n 7.5  Jr. could not find transfer of Trust ownership.')

#  8.0 Confirm final transaction was signed
if(not monitor(jrPublicKey)):
    print ('\n 8.0  Final transfer confirmed.\n')
else:
    print('\n 8.0  Final transfer still awaiting signature.\n')








#
