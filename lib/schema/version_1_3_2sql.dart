/*
 * spdx-filecopyrighttext: 2024 open alert viewer authors
 *
 * spdx-license-identifier: mit
 */

final version_1_3_2sql = """

alter table alerts_cache add column enabled INTEGER NOT NULL DEFAULT 1;

""";
