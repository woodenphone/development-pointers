#!/usr/bin/env python3
# -*- coding: utf-8 -*-
## Generic python module boilerplate.
#-------------------------------------------------------------------------------
# Name:        NAME
# Purpose: PURPOSE
#
# Author:      Ctrl-S
#
# Created:     YYYY-MM-DD
# Copyright:   (c) Ctrl-S YYYY
# Licence:     <your licence>
#-------------------------------------------------------------------------------
## Stdlib imports:
import argparse
import logging
import os
import sys
## Library imports:
## Local imports:
# import utils
# import config as config

## Log handler for this module's scope:
logger = logging.getLogger(__name__) ## See: https://docs.python.org/3/library/logging.html


def do_one_item(foo):
    """Do one unit of work"""
    print(f"do_one_item() foo={foo!r}")
    return


def loop_over_listfile(args):
    """Process work from lines in a file"""
    list_path = args.list_path
    logging.info('Processing listfile from list_path={0!r}'.format(list_path))
    with open(list_path, 'r') as f:
        line_counter = 0
        for raw_line in f:
            line_counter += 1
            # if line_counter % 100 == 0: ## Print status message every so many lines.
            #     print(f"ln.{line_counter!r} raw_line={raw_line!r}")
            if raw_line[0] in ['#', '\n', '\r']:# Skip empty lines and comments
                continue
            logging.debug('line_counter={0!r}, raw_line={1!r}'.format(line_counter, raw_line))
            cleaned_line = raw_line.strip()
            # if line_counter % 100 == 0: ## Print status message every so many lines.
            #     print(f"ln. {line_counter!r}, value: {cleaned_line!r}")
            ## <Do some task here>
            do_one_item(
                foo = cleaned_line
            )
    logging.info('Finished saving items from list.')
    return


def example_print_params(args*, kwargs**):
    """Just print out whatever arguments the function was given."""
    print(f"example_print_params()\n args={args*!r};  kwargs={kwargs**!r};")
    return



class MyArgumentParser(argparse.ArgumentParser):
    """Custom parser for handling args from file(s).
    Example of format expected: 
        '--paramname=value'
        '--parameter_name value'
        '--flag_1 --flag_2'
    * https://docs.python.org/3/library/argparse.html#customizing-file-parsing
    """
    def convert_arg_line_to_args(self, arg_line):
        """Custom line hander for parsing argument files."""
        return arg_line.split()



def parse_command_line_args():
    """Handle parsing command line args for this script.
    See python docs: 
        https://docs.python.org/3/library/argparse.html
        https://docs.python.org/3/howto/argparse.html
    """
    logging.debug(f"sys.argv={sys.argv!r}") ## Record script actual CLI arguments.
    # parser = MyArgumentParser( ## If using custom ArgumentParser class.
    parser = argparse.ArgumentParser( ## If using plain argparse library ArgumentParser class.
        # prog='ProgramName', ## Override autodetected program name.
        # description='What the program does',
        # epilog='Text at the bottom of help',
        fromfile_prefix_chars='@', ## Treated as file of arguments.
        # exit_on_error=True,
    )
    ## Mandatory args
    parser.add_argument('mandatory_simple_string', help='Help message for mandatory_simple_string',
        type=str)

    ## Subcommand(s) * https://docs.python.org/3/library/argparse.html#sub-commands
    # parser.set_defaults(func=example_print_params) ## Specify a default function to run. 

    ## Optional args
    parser.add_argument('-s', '--optional_string_value_a', help='Help for --optional_string_value',
        type=str, default=None)
    parser.add_argument('-i', '--optional_int_value_a', help='Help for --optional_int_value',
        type=int, default=None)
    parser.add_argument('-f', '--optional_flag', help='Help for --optional_flag',
        default=False, action='store_true')

    args = parser.parse_args()
    logging.debug(f'args={args!r}') ## Record argparse result.
    # args.func(args) ## Run a function directly from argparser.
    # logging.info('Finished command-line invocation')
    return args


def main():
    args = parse_command_line_args
    pass ## Actual module direct-invocation functionality goes here.
    return


if __name__ == '__main__':
    ## Wrap script functionality to log fatal exceptions.
    logging.basicConfig( ## Basic logging to file for standalone use.
        filename='example.log', 
        encoding='utf-8', 
        level=logging.DEBUG, 
        format="%(asctime)s - %(levelname)s - f.%(filename)s - ln.%(lineno)d - %(message)s",
        datefmt="%Y-%m-%dT%H:%M:%S%z", ## ISO-8601 style.
    )
    logging.debug(f'Started log.')
    logging.debug(f'log_file_path={log_file_path!r}')
    logging.debug(f"sys.argv={sys.argv!r}")
    print(f"Starting\nsys.argv={sys.argv!r};\nlog_file_path={log_file_path!r}") # Startup message
    try:
        main()
    except Exception as e: ## Log unhandled exceptions.
        logging.critical("Unhandled exception!")
        logging.exception(e)
        # raise e ## Re-raise fatal exceptions
    finally
        logging.info(f"End of log.")
        print((f"Finshed. sys.argv={sys.argv!r}") # Whatever happened, remind invocation context.
