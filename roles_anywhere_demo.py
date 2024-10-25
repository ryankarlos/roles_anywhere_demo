from iam_rolesanywhere_session import IAMRolesAnywhereSession
import argparse
import logging
import json
from pathlib import Path

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
handler = logging.StreamHandler()
handler.setLevel(logging.INFO)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)


def get_roles_anywhere_session(profile_arn, role_arn, trust_anchor_arn):
    with open(str(Path(__file__).parent / 'passphrase.txt')) as f:
        passphrase = f.read()
    roles_anywhere_session = IAMRolesAnywhereSession(
        profile_arn=profile_arn,
        role_arn=role_arn,
        trust_anchor_arn=trust_anchor_arn,
        certificate=str(Path(__file__).parent / 'cert.pem'),
        private_key=str(Path(__file__).parent / 'private-key.pem'),
        private_key_passphrase= passphrase,
        verify = True,
        region="eu-west-1"
    ).get_session()
    
    return roles_anywhere_session



if __name__ == "__main__":

    parser = argparse.ArgumentParser(description='roles anywhere arns')
    
    parser.add_argument('--profile_arn') 
    parser.add_argument('--role_arn')
    parser.add_argument('--trust_anchor_arn')  

    args = parser.parse_args()
    roles_anywhere_session = get_roles_anywhere_session(args.profile_arn, args.role_arn, args.trust_anchor_arn)
    s3 = roles_anywhere_session.client("s3")
    logger.info("roles anywhere temp creds to access AWS services")
    response = json.dumps( s3.list_buckets()['Buckets'], default=str)
    print(response)
  
    #uncomment this and it should not work as role only provides access to S3

    lmd = roles_anywhere_session.client("lambda")
    response = json.dumps(lmd.list_functions()['Functions'], default=str)
    print(response)